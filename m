Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020110.outbound.protection.outlook.com [52.101.189.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C11F2BAD;
	Fri, 20 Mar 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016448; cv=fail; b=CSAUWvYlmaBlRJIesUpo6pvBorJn0k4OTIOvpq6Wl86PaPQNM2Dftqr8Pn8lxKUPj8qO7Nie4khVyFzJffAK9cCMpt9Po8qx94vrVdOC5rCPGlrfJyCjEX+wbu2xZASEL5IDQTYddv047eR8kANjyAWy1kaD1ycx9kyCxRSFRFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016448; c=relaxed/simple;
	bh=kqwQtYFLG72aTDjw/mLnOwjyc+7ZvDV0SBdmnanwuGI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nMZgUYCJ3BECFeJzDA+MkG5pplNLep4BODbdnAlYO3s06vGYeWQu6S8seXYUe80o8OGLMski/1Z7LIhEj7o736DWzz7o1GHtrGBtI3l/u0maCwVnylowf1T4EdeptTRL5gSY+UsgpVKbObTvKlmuYNv3d1yWsIK9Nxveups+JuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OSFeqHqD; arc=fail smtp.client-ip=52.101.189.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OSFeqHqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B35JD69BemNvpZ+5YRoz63W3gCHXElJsozoHtlFh+Pnw8F0wcy3rc5HsNMOCd7T9gQLYGkGri0KGSap/uetmMe2l2CJ8gpKcZqfrEO+9rojU1fKcMANvPPKWdPqMUveE9G9mp1+MIa5nRBzLdeLxT6vsTZRRWAAX1uqzow24i3T2z4p7n9Jdw62eqAWoM676eDRiiFhMD3B0Hg8IyabEYOtJ9JuS/4jL2k7png0tWsTxgKZBkXsTqJpDE8OYWDiACzYQm2ucjENXCmAYygd7LWie2+P82SwUPRJqkUoxya1YjryiHV0ceLh9RueSCImjAYJWRcJj+T/HTjcFbUep3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZefKfBcnqELEUvfygumT+9YwiFTLDE+/q2L8SmoUfFY=;
 b=Fi8cxJodig7kIfVAbJ2IZL2pjGdO1ECPxv0cjJX/0snbI7HOsUtnZE75vicF+omyMVNH3dAFoKms572K/AY9RT2vuRkqiQV6KXxvO/faszI9r4cdKYsAKtWdxKWU2sLRa7xYmqVgOTQ67xZdCrnKiW40ppLAawpVMD46Ok6bVUo+w8QLaIe7i0WQakM6R4PueXZ9qWTEY97vQoiCZ5qFceYKLUfh2IxIov3LX9WruJNRtk0kluGUw7BkcT2p8RUYinCGQsBrRTA2DVaIlhTELrQBGIqGc6o9KoTajGmjSbVs3r4Ix/3tYPGk3P2rq+Ei83FrgWzUKtw1A+TwmdCDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZefKfBcnqELEUvfygumT+9YwiFTLDE+/q2L8SmoUfFY=;
 b=OSFeqHqDKnyJApsSZH6WMd6y/6GWqVefa8zQMQGnfsXGG3u5kGz2U+QZHi5wLe8rh6jmuB4T4AglRox5AmqnmRXwRnYUlPEtGDjx6EySBmh4e6FNnaYSnJF57ie0h9140H8vVt5M3ynhsBWOW9QuiOUtlYRmwXTr8mdwnt6PNST35NiTTMMciDDu7JwXfGhXzWUPev+q0XHgH5ktCeobYJG9rec8xpsQk3p1795Mp5eNsZrzr/FkLK+myN2ksCUpuh4CPMtTv+CLTD+m65dX5YTMFiZtmhNkuZp7ZdvohThtm/U2VjcAFY90VqX2BxfO02awfVs1dS9jkSmgeO07GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5702.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Fri, 20 Mar
 2026 14:20:38 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 14:20:39 +0000
Message-ID: <7a8faee8-0eb5-4e58-a6d5-ef711791e3f4@efficios.com>
Date: Fri, 20 Mar 2026 10:20:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NULL pointer dereference when booting ppc64_guest_defconfig in
 QEMU on -next
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Michal Clapinski <mclapinski@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260319233745.GA769346@ax162> <abzKcGiRSR_E8lLN@hyeyoo>
 <7780a471-9d99-40a7-ade7-0c4594ac36c7@efficios.com> <ab1J9ODkX5iChu-C@hyeyoo>
 <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
Content-Language: en-US
In-Reply-To: <7458d8fd-5922-4e0b-9cd5-91880282aaa3@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f215cec-4025-447c-2d1c-08de868bdcad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s2xMijAGU+79/lUOUm9Ch0NolLawM3QMeIodWhMkzseBmccmGi8jo7VypVFu7+ySqhh246Aann85ExD/h/nEk55uYaExVu38wIERLSMKtzM1Fd8M/Otw67sHyp9HTucbdfCHjcw6qUgZW3REe1CqXbi6/AnMDd7g/zmOvkFvSfJn83E06z2w4RFcTCEg4RhvbP96ExuSe88RSYGoCnM4sGT50mIfOlt3uEbAR4hECbn0P/wbcX5LtKn9j5GGJxDli8ookB6XxnGJ69T/tQW6cFkjuYtk68tddJUGCt2rN0m6H7mgt+y4AzOQXejl3RNkqOIus3u/kRymw7OKrPY/cvuc27Hr0EtvzzHkHnVAA8tDxznmy5L7QTLkB3mHKh5upU8R8bZBRUSy7xH96Iedy5LmjQMDYC/ABSVZYTw9M2Qo2O+OdCw1UlhGlfLMCLi0lUSyIjfSc8soIacNzIQanF9Z1NRRcnucZl4NliXcBPnvm/tobgjyNXLKeST/Gk20JXX48MEvxC8ImK50GRo2YN+MScq/N9GHLfBSBaMwnGHIAM14NAj2t5srjfU3SSFZR5mJhbEbNe9wNCElYRSTCvCE0khTmvNU0nbIFnEhhzydHUbP3H6yDny9ifd0Z7YJRhKicK12DKrLstJg5Dn2+5qkY3jL002P/eBLwGElg6VSbQ2FiNvEEq0K2J+jEVLJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3BSTWJWdnp5ZXJaeEVVRVBFYzQ3d3lTcitYN0Y2MW5yMmRIMHJMMmxBVTFI?=
 =?utf-8?B?L25BRlRQeEFjWXVFTjZUMzVTSlNaMUl2YlFheW5xVXZIOW1lbTA3TzdxaHNl?=
 =?utf-8?B?bG9UNmRoSXdOSU4rYzdmMXZSdGNNQ3A5V2tNcU9jSm93WWFTS0hTTG1NdjdJ?=
 =?utf-8?B?MCtCY3Y3MDkzeDU2MXNMbHFYSDZHS3N2MnRQQ3YyTDNHSzRuSW5CSkZCVEZS?=
 =?utf-8?B?czQrZHQxcU11bEVSdVJ1T1pmaTZGK2VheUVSTzlFeEkyUTBaRGVzUG9aWHFP?=
 =?utf-8?B?c2F5QTJPVWtxc2g4aUUzQkFWMUNOUXZQL2JYUUREWGQ3bE9WbkQ1eVpJQnho?=
 =?utf-8?B?YXhaWG9SRUNlcCtNb0JuK2NLZ0wzSEN6YllnRzdLWUJScGJscGdwVVN5ODRw?=
 =?utf-8?B?SFdUaUZFSFpHbjJYNWNneDFFcXM0MHZOeEJ4U3l5RUpQOHFZaU1KUWZ2SkQ3?=
 =?utf-8?B?ZTBIYitsMitha1paNWFRYlVTY056aUhTSEFrRDNyRHNhaDY0d0kwMnVFd0F5?=
 =?utf-8?B?ZWVTdExRcFdvakU3RFJhS1pyNkJFbVI0aytNT0I4OXM4YkpXQmk1ZzNNbmRV?=
 =?utf-8?B?UmVMVERncUp4RllHVUUvdHM2NG4wRU9jWUViWGtRWWppRjJ2aE44Z1doK2RV?=
 =?utf-8?B?WkRieUJlK2xQeG1kNndRcCtsNnhNU3pnU1duOGIrRmhqOExpZm9WRWNYNmhH?=
 =?utf-8?B?ZU9qcWZnaElKalVpWUw4QjkvRjhDTkxtaXJ2YVhjdEVrK2FJZFB2cmhTdFBq?=
 =?utf-8?B?NnFUT1dHUDJ4c1hoL1hFZlR2VTgrcG9VRk9OZE4ramp0dldLUGt0MGovM3po?=
 =?utf-8?B?TGQ2UDI0THZIaEMzeENkUkxBK01Dc2JYc1pKVmU0UjlGdmU5dlZZRFRBbk1l?=
 =?utf-8?B?cURlVDNlTzgwUm0yZVRaWmNkbjYvMkxjTklFeVVFM1l4d2ZhSGNmcC8xdEN1?=
 =?utf-8?B?NHJQNjVlcWlDeXJqeTg5RU1GZEdxQkFGRVNPZnl3Sk9ha2U0SGtlYUtrZTJN?=
 =?utf-8?B?RnZDYm1LSEN5M3h2czgvZ09PSEJnMTJ5SVdCUVJtTTlZc1gwUUhnSlRpWXYv?=
 =?utf-8?B?R1ZuS04xWTBrNHpmUyt2dXk4TWNYdTE2bTZMZEw2Ymhuc2dtcFQ0OTNXZCtW?=
 =?utf-8?B?eC96MWV3MlR5b253djJwemxOM0RwTS9Maks1UTNCU0piOEs2RWNOY2laeXRq?=
 =?utf-8?B?NElRM0JvOXVIc3ZPbzNDQTJEa09vZzBLaWhpcnpwTDgrVEMvcFpIbmdMby9G?=
 =?utf-8?B?MGxlbWhML0pWdkNlN2s5WEZQNmVJajlPRko4MXlkQWErZVF2a1ZiR0JZSy80?=
 =?utf-8?B?UFZyWDdlL2lNcG5MaXR1L1E5dUhNR3RqQzlvMUhSSUhwS1NPV2xINkNWNDUv?=
 =?utf-8?B?K3VlVFJ4aGVkS2xLZi9XVnA2bHVrMjk4OHFTdGRkbm0wU0FjZkd2aVJ4MVhR?=
 =?utf-8?B?VzFkdk15MUw5aHZwcVZkdHJLd3V2VVFycGo5WlhlcXErUFFzV0c5eVBENS9R?=
 =?utf-8?B?cUIrNFdjNWM4bExURjJwTGRDYjNIbG1EUzVkdmI0TXRqOGpoVzdDdFQxZmZn?=
 =?utf-8?B?dG5SNkl1b2dhUDE3RUV1algwN0pabWRUaVlmQmdqNlIxNjRjZWJpbFUzYnRx?=
 =?utf-8?B?NXB0cjdpWjF0K05NQmhJck1lSmY1MkMwVmhTdUFqd24rNlY1bDdtb3paYmdj?=
 =?utf-8?B?RWhjL2pURWN0NWVtVXFYU0U1cExxaVUvSjcyU21iM3k2bFJlVkg3eGtPbHZm?=
 =?utf-8?B?L0Yvd3h2Q3kvaTBsVUc0S0wySFdrRm9Tb0U3bzZOL3UreTlGUWRSU2Q3d29q?=
 =?utf-8?B?WGVLNGVKZzlRVnBsWTlKK3AvVVhlVE1wRndvRXZmQWlvcUFpNlJQQnBJNVJv?=
 =?utf-8?B?alNjSHZaQUtRVGUzazJJWkN0T0Z5REYyR2dpOXNLRUtsdjlLMEVOUkt6dGNq?=
 =?utf-8?B?elVISDRUOGpTcktVOWVzNHptRE51ZUxNbm15NllndGMra1BCMndpSU81V0I5?=
 =?utf-8?B?SzUwMmhMOEpLVlJSbUNDNDR1Z2FCVlMvWmo0YmRmc1dCSUJsK0tMS05GWUlQ?=
 =?utf-8?B?MC8wTEJ2TmhTYXRVSjh5WVZYR0dsRyt3NW9MTVNZV3JMOEVaRHNCR3BNYVQz?=
 =?utf-8?B?OXZNbm9xRVpoN2xGeWxKWlgzaWRnRG0rTE1hY3VZL2RqaVU4K3lvMXhUT1N5?=
 =?utf-8?B?QUpjR0pZT2xQTVFsYjIyaWt4cVpuUHVkOVcxNlhvNHVlSEZtVU9HdGdGVzFR?=
 =?utf-8?B?WXRsN1R0Mzd4WVBjcWhYVitwTm5YQTFMbEVqTnhxSmt4azE5WkxGZGVEQ1h1?=
 =?utf-8?B?dU5jTVBKT241Zi9uTlFpMUlJUXoxWkxBKzZ2V2JIeGZUVzF5SkJFekQxSVY5?=
 =?utf-8?Q?F7MjvDaw/vdy6vs7uq7Zyl0rFeO2mw5Nyx1Uz?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f215cec-4025-447c-2d1c-08de868bdcad
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:20:39.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyI7O0Fm7ZnlgHUx3z6O87Xu7MqjEh2EYUZHkAFhyRhMjC9iodaIujX5xV+uU+w5saPa+g25zEobikC6Q1HWtwnPo2dlUqC8hXvHyq/yvEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5702

On 2026-03-20 09:31, Mathieu Desnoyers wrote:
> On 2026-03-20 09:21, Harry Yoo (Oracle) wrote:
>> On Fri, Mar 20, 2026 at 08:35:46AM -0400, Mathieu Desnoyers wrote:
>>> On 2026-03-20 00:17, Harry Yoo wrote:
>>> [...]
>>>>> [1]: https://lore.kernel.org/20260227153730.1556542-4- 
>>>>> mathieu.desnoyers@efficios.com/
>>>>
>>>> @Mathieu: In patch 1/3 description,
>>>>> Changes since v7:
>>>>> - Explicitly initialize the subsystem from start_kernel() right
>>>>>     after mm_core_init() so it is up and running before the 
>>>>> creation of
>>>>>     the first mm at boot.
>>>>
>>>> But how does this work when someone calls mm_cpumask() on init_mm 
>>>> early?
>>>> Looks like it will behave incorrectly because get_rss_stat_items_size()
>>>> returns zero?
>>>
>>> It doesn't work as expected at all. I missed that all users of 
>>> mm_cpumask()
>>> end up relying on get_rss_stat_items_size(), which now calls
>>> percpu_counter_tree_items_size(), which depends on initialization from
>>> percpu_counter_tree_subsystem_init().
>>>
>>> If you add a call to percpu_counter_tree_subsystem_init in
>>> arch/powerpc/kernel/setup_arch() just before:

[...]

One thing we could do to catch this kind of init sequence issue
is to add a WARN_ON_ONCE in percpu_counter_tree_items_size:

size_t percpu_counter_tree_items_size(void)
{
         if (WARN_ON_ONCE(!nr_cpus_order))
                 return 0;
         return counter_config->nr_items * sizeof(struct percpu_counter_tree_level_item);
}

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
