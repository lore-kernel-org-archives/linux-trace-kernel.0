Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021091.outbound.protection.outlook.com [40.107.192.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A082773CB;
	Tue, 13 Jan 2026 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312314; cv=fail; b=kc36fxPC+tpNptvw+z7eiU5szap4zoFAEcVKtfae0PxbdQB253kldc0vZCGGWR6narFZFnbRiFPWBIyAQF3k4934fbaEFe0606hYZLqwt/9A81vBlD7lLn8YTeqCqGcHz6kjOWNmPC5gHIl20BPFaOt+esbXU8gyMxvC1U0lZQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312314; c=relaxed/simple;
	bh=DHtTYjz6gnd/7bouYy4ooewIwGu2UXd9sn3F9dYtHqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VrXThtt1YbHmtWsbrZl1TtKYxAb9+DkOMRmUmXhLAWtZU57cCAY4pzlbyYmOaWckivw1S4XoYP/ejfkADDciJq3AGXXOgTTZEIQCk4EQO0SKE4h+TGzyUwsNbUisRlaJ8kpUOwfz6IchHo1HO5BSN+kUn69vaprntq+zId8yuLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CiSbhKYJ; arc=fail smtp.client-ip=40.107.192.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CiSbhKYJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqhvcn+3nSfITEf+jG1ezM3xMJRfeJxnWQV4Pi4LUSC5ZrJ5Eq7wMKqMCqchfXQgLReWnosXEsrCiQ1Du+ZDKf3HxQ2T1ghqVULl2t1NTY4injd0xBkzb3CF0gLQoxWlmqzvUGU0HbBr7P/3Y9oMPUhvMjuKVfK6x6uV+apUT+j1ZO+a6SFZDUWsvPkT07fUx/F/bZSCJO8gwx7MF8UkU9fgbvY/KGpRSC7yI66eY47fTzf1S4D2RNkELhphvNJlcTxvaFPAZHoCwDvAgEK6aCNcx7Na8hRwnDHoj2f1khQlxkE6mjqWdq2tNNArPTAW5d7RLkYWsfR0dQbH7TjXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNpDQG1AeQWl9vqmtBEpOwBdLB3//Ue4XMBS4qOWd2g=;
 b=coUxqh1PRfK3cJvYf/H5RFp7fKtYo5Vr8xCVWP463/pLjUTHeJ265eVHSASBNrA+6BBOvmAHhAfR6kAhdKkYNkbBRf7NLslNN46SxOADPInkCTHtAc2P5yzUa5rjVmalJg7WsxutmpzlQoAdCwU/D1QNB/49DCxXj8t4dCrTWORillSdae/y0y8jYnzevhlKVemlMEJ7Ymuii0AfdPURH6MMt0wWi0fMMy9ogou6L9XZRjXefu9mJA9ljAixSfJi0susI9ZuB/vsmLh0PjpiL0AV0gsRAK7ceyF/oYM9HE1SNxjBQffqjw/Ul8nrnon91CWLqaOuYCn0FI1APwPPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNpDQG1AeQWl9vqmtBEpOwBdLB3//Ue4XMBS4qOWd2g=;
 b=CiSbhKYJy/OCI7JF03VeFESUK7te5PCGrJSJCca4cdUo3A8fRrK1E9SmCDZy2fzGKqo6xyVfDEOJYYVT8CUbQfb9iGTJUKioyRfgxBWTeKwK5fi6wUbR06wOPdCX/rSoecEj3clFgNVDR1inPLvAKVvLMQuXI9rFeJ7NJhMI+n1qlE6i4q/sePlscsBVXMhdPcGMonatwaRtpcMMttjrK42eM7n1k9s70rFc5umEYSRHmqztkRWMWfQ8467BjV1toh+CrCyJpan8SZnSWf8WbEYwCJ0/UltRRIitpZ9FpnnxWxkPl4VAeFuVuc5GpgWJb0000PYNb78Fy7zdN1K+6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5441.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 13:51:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.008; Tue, 13 Jan 2026
 13:51:47 +0000
Message-ID: <c99778c3-6ef0-48de-98ac-10913419ec90@efficios.com>
Date: Tue, 13 Jan 2026 08:51:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
 Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260111194958.1231477-1-mathieu.desnoyers@efficios.com>
 <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
 <aWSz5OHBwtfYrruu@tiehlicka>
 <f2c04264-17ca-418f-bc43-e8aa6fa6cd0d@efficios.com>
 <aWVP9sPqG8VC8Oq_@tiehlicka>
 <b779c646-64c7-49f8-8847-8819227e3f1f@efficios.com>
 <aWYPWNIv4lR2FpUZ@tiehlicka>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aWYPWNIv4lR2FpUZ@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: 8490741c-aef9-4e7c-5466-08de52aae503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUR5eTNGQjYxc05JY0NQZWJ3dkVuS0VFM0YvVzdBS3NtMFpDbHBYKy9oVGxJ?=
 =?utf-8?B?K1RvSzcwQVBKT0dpTEtyMFdzU2Y0UXFUNDZIbHNCa3BGVG9JYTh3Z1MxbE96?=
 =?utf-8?B?RlBoMmtGcmo2ajlVMkMrMFc3aThpRDhCUjRtZ0dUT043YkU1Mms0aTZ4NzJm?=
 =?utf-8?B?R1krVTFNb3psRzBJMnFBSGpBRWJ4K2NNMTZaREdBSnFvam5lbUt4bVNSa3N6?=
 =?utf-8?B?UmozVmFTVzJYREpPb2FFTDlNQVZodVhiOE5STDc3WStVdHBOUFdCNzNLenY0?=
 =?utf-8?B?OS91c2YwK283ZFRmY2VpTTNtWGNhbmdIYm1EbkFTTjUvYW82YWR1RDJGT0sz?=
 =?utf-8?B?aEpTM1lnTVpyQkdqWmc2WEZXSkpIV2xEdFhXbHUvR0IxNkgyQ09oMnRlSzlI?=
 =?utf-8?B?dnJIczE5NXRDeTFLQXZJd3RMdTNUQTU4dGlydjQxSmV1Z0VBUVdEVHMzTkNo?=
 =?utf-8?B?cUFacWlYdW9Sd3RKZUhzY2gvSjYrVzN1TTZOeS9uVEdhTy95NlRsVVNzSVRK?=
 =?utf-8?B?bjlOVFZmMUkxdXBzdE5vYWdzQ0VzK2hvSzRGNlRSWEU1YXc0ampaQ0djMExj?=
 =?utf-8?B?WVlyV3VLd0pYV0RpdjAvT0JRVk1HSW9VbXAvSUlNejF3Tm5LWmIvQ1ZFdW53?=
 =?utf-8?B?dmNoVFFxYUsvUGFNTjZLTGVHbFZtL0w5bXlHb0FlVjJ1WW9scFF3RW9FZW1W?=
 =?utf-8?B?K3NzTGtVdCsrR2dzZHNJY0NYYS9uTFMxRFdEOHVOeUlsU3Q1cjc3UkVwWW5L?=
 =?utf-8?B?V05wUnBsSm5NdHVXNStLdlJlUCtFVDE2c2VjcmZPdzNKa1pKc2RNUTN2Tyti?=
 =?utf-8?B?cVlkTHcyb3pNTGJFZS8vQWErRTVlMTNhTjlUVk5SaGlZVm9HcHluVVNTMDln?=
 =?utf-8?B?MldrVnRaWXRBUXJoZ2hzZU5iaWJhYXIwc05pT3JyY2JrSDB3NlpZbGppMlJa?=
 =?utf-8?B?eEo1em1TL013b2MzSDJLSExyZU16aEpDZjdLdC9WczFsU2p6YXl0U3EzQnZk?=
 =?utf-8?B?b2doaHVyS1cvM2xJLzM5bGZwUXp6WnA0dGJhMDltUS9va3U2TTRWSlZzbnZz?=
 =?utf-8?B?WHQ4dDNZRHVkZUVzUkxkQVRDd2JQM3hhYzRzNm41Um9paTlZMnE5WTd2Y2Vm?=
 =?utf-8?B?Y1J0cHNzWHR2UnI3VjZDeld5bVA3dkkvNFRtazFCSEpKTWNmTVRqWWVKcitt?=
 =?utf-8?B?c29ub2xrVnExNUg5VjNnVUJuQlhYai9lbjZadjNZVUh0S0hDVmJTS3kwTlhS?=
 =?utf-8?B?YXR5cUk0QWdzTDY3bnRlL1lnR2hHWW9aUCs4dzJKU2pXQlFQTDA0N3hiY2Fa?=
 =?utf-8?B?Wm1tNmdPemIrY3pqczBkbkNWU1ZFc1FnV28wOU03aStCbmp4bU1Nb3Z2SGVx?=
 =?utf-8?B?K2U3eEVGTDVINmVkTFlFNWo3TDdJWFZxMSswMDFvTG9QVEZIRC90cEhYVngw?=
 =?utf-8?B?WWIzc25rcEFmdkpHNnR2MExpeE94Vm5zTXJFRllFUTFYWXVxYXdaUUNuSFM4?=
 =?utf-8?B?dGhXTGxJNlcxNXFRQi9BMmNwOWJMUXpqT0ZTVmRFYmxhM1BCbkovbHFwMlBR?=
 =?utf-8?B?Wk93a0xINVZQR0tFWXFJZ2N5dlM4RFBjaDhXUHZ5dURRYmpJZWN3MUY0UExK?=
 =?utf-8?B?VUVzS0pZRDV2VFVXQ3ZhL0RTeEZVZ2FubnBVbTRhL3lPUnNtSS9lU0p1S0ZK?=
 =?utf-8?B?YjNmdHl2dHVTSjFNbnB4bnErWDYvcWZlMnlodTI3QVpudDhPbVVBSW0waEVs?=
 =?utf-8?B?Y1M5WnRVeEgvV2VpaGtoWEljUDg4RUtwbTRxRnZDMDRLeW9qbEkxMTBSYkox?=
 =?utf-8?B?a1ZUcm4wUUZXa1lCVXR5ZzQwNVRoR0F6dDl2emJ2Nm8xVWNLQUxUZjFLa3lN?=
 =?utf-8?B?YzhwYUZuWldjOGZuSENqSUNnTGJZVHB1dG5MeXdTclRFYUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxEdzlKcFJkR3lEeWl3ZnJpSUtaV1E5Uk9iU29sWTBtWHhJRWpOdk43dUxa?=
 =?utf-8?B?aStqU3V3VVJFL1JLYXAzUFZqZ2NmQ3YzRnRXUDkvNy9ZYnQ3and2U1hmdWNh?=
 =?utf-8?B?M2NUM054U3lIclNieGIxbFNmalk3dm9RUEoycDIyZThyMDZhb21rV0ZsdjY2?=
 =?utf-8?B?UkpMQUdTM2hwbHo0RzF6Uk5icnNYalZWV1hXMGhvOFYvTVM0cmFoQ29kc1Vj?=
 =?utf-8?B?LytrMitvRXBCN1NSbUlDcWVLU1l1ZUlJV3VKY2VqL29YcXZicWEwTGFsaW9k?=
 =?utf-8?B?b24yMVpWN3J1NWwyVk5sVVkyRDdnZHcwd1M5N1o5K3BlVUpCMnpvUDIxRnFa?=
 =?utf-8?B?VVpadk05cmxLcGFBMFVJamJ3SjFwVzg2ZUJla2tuSDkrZHRIK3g4dWVxcWRq?=
 =?utf-8?B?b0thdEQ1VVJvRitJeHZqL2l5TzR3c1hjRFFLcDJPcTcxYldNazRHeU9raGYx?=
 =?utf-8?B?dFUyNVQ4RzhnWDRwS1h1SkxWWm9lRlhJaGFNaUgzdFhQdisrWDQzek5zWEt0?=
 =?utf-8?B?VUhXazRDR3pKb1Bldi91Y21pT3pXUXgrVGhlNmhXN3hwK1dIc1RFVlBQZmNC?=
 =?utf-8?B?U3V2WFpOSlNDNWJCZEtYOGRncDgzNWN5dUdreXN1NUQ2N2xNMUZZaHJWY3NR?=
 =?utf-8?B?NTFYc2FBa1NBV2tQTmVRNzl5K0k0KzdIdXBsd3ZjV04rV0lwVVMyK1lSeFEr?=
 =?utf-8?B?eml0Y2JIQWxCOG0yTXdlZS9ocUpEdmtzR1VSaDNBbjRVZU04NnNhT2NRdm0z?=
 =?utf-8?B?d3RLbjhCOTY5UldZYmYvenc3eU5ORkZxNlZITUVaUHhURjdtK1g0ZTdTSWhE?=
 =?utf-8?B?VEJFeFlxVjdlSU9UdHU1YmY2QmU4eDc0dlVLa09xMEZ3SXV3YkVaZnlLd3Bo?=
 =?utf-8?B?MEduSXVjN29JdWNxWFhqd2ZyWHljdVoyVlpEYjFSOEtmZklGZU9PbFYyaU8w?=
 =?utf-8?B?WGZDZXZQVkR5Uk50ZVJ1VFJGSm5kdC9xeUlYMXQ1YWFIY2VzNUFCZjErWG1S?=
 =?utf-8?B?ZXRJWDVyaFlSbWZXWU1ZWVIvWnY2dGRtWnFqUG5UUEEvMmo5Q2VBQUhvMG9y?=
 =?utf-8?B?Y0NHRytQRys5c3FHMzNHSUhMVkdxNGJkT2NVd2I0ZEI4c0xOVFhaRjNHNGNE?=
 =?utf-8?B?bWd0MnREZ01Sa0gyTnp5VnF3K1doRm5WME1Bd1hYUC8zU2I0MDNaQnNhYmNK?=
 =?utf-8?B?ajhNdmNDaWxlUUZhN3hqMXdla3JHQktTN2p2U1A2aDFSYkpicVp5Zkt6dHRV?=
 =?utf-8?B?ajBiM3ZKL2lVYW14dVFCRVRuZisra3JjWm9VcHFraU94a0pyZDBkZlQ1dlE5?=
 =?utf-8?B?aTdoZGNtRTNXZEZBSGJ0TldSTjJIdldxWkZNQXE0ZFlyVW13eVBZTHBhTGRF?=
 =?utf-8?B?N281ekZtaUNCT3FPWnkwbDF0WUFnUVFYME42R05kMDU4WXYwUG1RdE45VVBv?=
 =?utf-8?B?SkxRekthc2diRHdLV0FuMmo3My9OQ2dnM0xQVDlXczViMzROZzVGTUxkNmxl?=
 =?utf-8?B?OXl6UllCNE43ZXpzZkMwNjVlTlRQS1FBNjBwNjY1RzFHaHJtdVJkQmlFRldN?=
 =?utf-8?B?M0hzK09zRWJtWTVReC9KYWt1cU42bXdycW1hWE9wVUYyd0dCUUhDRjhZNjkv?=
 =?utf-8?B?MjdQK0x6c1h5TEhVbkYxOHZrTTdxci93RTAxYjFPTEZ4Vld6TW9MVGw1cHRm?=
 =?utf-8?B?TlU2N29mZHJPNUxpdmphVDR1ZE5hRWxmWVRsZ3dXU25iRURieEhGd21QMlRa?=
 =?utf-8?B?MFdXN09CU1FJTURrd2JyVXpKRjVBOG5WZVN2emwyQUxHYklyTXFTN0p0TXEx?=
 =?utf-8?B?NnhROEZNZ3FNUFZhOVR3WWtLTjhnTHcwVHloWGlRNDBzbkxNaThlRFpIaWpw?=
 =?utf-8?B?RjBZUmdTYW1QbUFOVkc5N1JidmFXVFFuaExHS2JlbUQyNUdoakszMkY4V0hh?=
 =?utf-8?B?MXk4ZlVvNmU2YjQwOVFoNDRQUFdENXlFOHlZOC9ZK0VSRjFiRWh0eHhLQ3lu?=
 =?utf-8?B?dlRUUTVOTzRCL2pYTDRWRThhS3ZzelA5eFFScTNWQ1k2S21kMk1FRldrenh4?=
 =?utf-8?B?OTNNbHdUZTFSbGZsTDRUM1JKSDJ3bEpGMmZsWHJmbHQwOXBnZzlMODlDYzdk?=
 =?utf-8?B?KzExTlozL3lUbG1LZlE5cTREY2cweGE0a0VRbWo1dm9MNGJUTHJoSWc0YWdY?=
 =?utf-8?B?T2kzSFZYVUpJbkhmaFpOdWtaVmI4TW5EL1dtWWRFSDc2dTBYcjZrdnNTQkVY?=
 =?utf-8?B?Ui9sWmFGdFJCLzNpWjhEbm1aQ1AxY2diR1lHMHFKRUxLamFmRk9tUUN4UVNW?=
 =?utf-8?B?dkU4Y0ZVS0tYdVF0alpic0VuOFlMZkk0K1cxUTNiRmc4TTAzaHk4U29DaXky?=
 =?utf-8?Q?FMIOCKyvErQ6kd+U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8490741c-aef9-4e7c-5466-08de52aae503
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:51:47.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zBeHAsSNJj59n3UZbSVUJFpVhRhlt1JCB6x5LBSs0DuXkbnY68mCjFONDhmyJTDayJQf1SUDsTp1gVR+Ff3Adt7KgmRtAcrLZqji/E8UOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5441

On 2026-01-13 04:24, Michal Hocko wrote:
[...]
>> Would you be OK with introducing changes in the following order ?
>>
>> 1) Fix the OOM killer inaccuracy by using counter sum (iteration on all
>>     cpu counters) in task selection. This may slow down the oom killer,
>>     but would at least fix its current inaccuracy issues. This could be
>>     backported to stable kernels.
>>
>> 2) Introduce the hierarchical percpu counters on top, as a oom killer
>>     task selection performance optimization (reduce latency of oom kill).
>>
>> This way, (2) becomes purely a performance optimization, so it's easy
>> to bissect and revert if it causes issues.
> 
> Yes, this makes more sense.
> 
>> I agree that bringing a fix along with a performance optimization within
>> a single commit makes it hard to backport to stable, and tricky to
>> revert if it causes problems.
>>
>> As for finding other users of the hpcc, I have ideas, but not so much
>> time available to try them out, as I'm pretty much doing this in my
>> spare time.
> 
> I do understand this constrain and motivation to have OOM situation
> addressed with a priority. I am pretty sure that if you see issues in
> OOM path then other consumers of get_mm_counter would be affected as
> well. Namely /proc/<pid>/stat.

Indeed /proc/<pid>/stat (implemented in fs/proc/array.c:do_task_stat())
uses get_mm_rss() which currently exports the approximated value to
userspace.

> There might be others but I can imagine
> that some of them are more performance than precision sensitive.

Agreed.

> All that being said it seems that we need slow-and-precise and
> fast-approximate interfaces to have incremental path for other users as
> well. Looking at patch 1 it seems there are interfaces available for
> that. I think it would be great to call those out explicitly in the
> highlevel doc to give some guidance what to use when with what kind of
> expectations.

I figured I'd first focus on the oom killers internals before tackling
the userspace ABI aspect of the problem, but since you're bringing it
up, here is what I have in mind, more or less:

- Introduce new proc files, e.g.

   /proc/<pid>/rss/approximate
   /proc/<pid>/rss/precise

Where the "approximate" file would export the following lines for each
page type (MM_FILEPAGES, MM_ANONPAGES, MM_SWAPENTS, MM_SHMPAGES,
allowing future additions):

<page type> <approximate> <precise_sum_min> <precise_sum_max>

And "precise" would export lines for each page type:

<page type> <precise_sum>

The key thing here is to have different files to query approximated
vs precise values, so we don't have the overhead of the precise sum
when all we need is an approximation.

This would expose all the bits and pieces needed to allow userspace to
implement something similar to the 2-pass algorithm I'm proposing for
the OOM killer, but tweaked for other use-cases.

This proposed ABI is purely hypothetical at this stage. Please let me
know if you have something different in mind.

When you mention "highlevel doc", which document do you have in mind ?
Something related to lib/percpu_counter_tree.c or to the /proc ABI ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
