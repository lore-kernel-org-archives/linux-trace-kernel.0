Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022126.outbound.protection.outlook.com [40.107.193.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5302E1EF4;
	Mon, 12 Jan 2026 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243608; cv=fail; b=YBJibwYHw+kHxdH8P51VP5qD9BuBeLO6Rr5ZanUwDHTXI7sJWxipAZrz+NBwaL9WVkXu70MjvNI2KwOlEj2auJpJGtTLj21+/lTrgyH7E0eCmJaGZJcbhy/PPdOc1PDaQ78+x8TULT0u9pfUN+A0zpfKd9DhzqkXajZDYiZJxA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243608; c=relaxed/simple;
	bh=pVWsfBEY4mzx0K2MWQ2sGCILKonI9aZk+24RVvg3YGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oznzQ65r9P/E2b0bIdev7Xgm0KztXSd/eCCKw295zaK4GYwm54rATkxnD86rpD+Gd6ZoLO4xlwRHkdoFmhRx5JH87eQGYcOgLkrhizOWW8ZozBJfp4TFZXzu6M7vc/dDKc6beYdHkXaRibsKOCryaOmKjbRDKOHosvQVx5iAYXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mI2bogSZ; arc=fail smtp.client-ip=40.107.193.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mI2bogSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJN/UbCilwcMmHAt7pHRZXGm0w6rgmD2CM7CyZrePx62z5XygG0iH80EQnyBIPAOHb5CkjSANolNVK+51gMuFbMvCjWHwsXiwGq8RwexN3sklhtvhvNpuoZAtgBJK/TAlhCkN5YWaPMtyaweg0rWIrMLHc5DxE0kOu1eZHWf8DcEo+z56ra0YW0VBzbTMjGBPJPeqCFoX0AaatGSRkWjAMvj2LjG3lURF9YLykmkIgff87JiOCkqqJy9yfrw40pnNIrosqrX4rtbwXH5Gb0riveNcjv1Qu7Y2g61lsVG+WbjKbZA2LYov6bhWpsnGYHP8PnrZWfGdP98+VLPzIIC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdhx1Zgfiu7mOC482jSIgIAbkpzo0TDeTt8j55SICSk=;
 b=mgfAAAyswcTTqfiys52SmODpfCdAq90XSljauEsj021A5O7cvwQheYQxY48GjmjjZy02wYiq1LTN47BK4ETXr7eO9dPuQ9Vfao1k9QknEwJVesRcPXpmTeesdOcNHQau0S2Mgd+KARDYZ9D4In1FxAZ+pZfIbf49uTz0q6tMVjD4EhavlaEIhRexXFor7TN58spF74jLU0D0R/RNqAN7x2FMTNkKMS5eb1YxE/GKQ6DB2IttitrV8cxV19aG+oG+mjwBhf0S/yyHrojjgXT6+QN7D08Y+1N9IdNg8ovcwKEHl1Ubuavufng+zhHdZ+HzPM+mCwMPlkYMvvOrrkl9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdhx1Zgfiu7mOC482jSIgIAbkpzo0TDeTt8j55SICSk=;
 b=mI2bogSZkyMY3PYf4VwNSqzshHwfC5v+rAUKkcpUFrQLUxcnCD+4QA/gbQ/nxr7+FwMgV/hInlWzyvpvw1gqHbWd1A8/goo4962XwnFu+tdMSpGr++IqNNmmZKSt5HVyqVzWOW9gKScoAraF279To5A+vVcF6Pn4dD6rrHIYUE/nVU9XedpKqVkhI+muvpYPpwe+q3iyhkmTNmmU+RAa33/Jqrb+oixihGgOTpzoRzdd1PGeNhAjSS7uz584i/UarSZrmMloXonLXHWefn3lsqwup0bTIktStNPlgFAL1zcvyB9s0Ov8ehQamk0438GjfaKGGs8EHbG8QGPHY0gFqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPF82B3F4D96.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::45a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:46:41 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 18:46:41 +0000
Message-ID: <3484db91-2de1-4ec0-85f0-1a7c91833604@efficios.com>
Date: Mon, 12 Jan 2026 13:46:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
 SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
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
 <tzgfnxf3tii4s65inlzghhrzgc5gkp2stugnuzuqnjraqbp57k@khqklb37lci2>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <tzgfnxf3tii4s65inlzghhrzgc5gkp2stugnuzuqnjraqbp57k@khqklb37lci2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPF82B3F4D96:EE_
X-MS-Office365-Filtering-Correlation-Id: 657e7243-b511-420c-6db1-08de520aed12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZtdTBIZjFOby93dzZ0ODFLWG8rbmhjaHEvWWYya0lDMGtXRUxqbTNOQlE3?=
 =?utf-8?B?K2dZdTFWQXlyVmtoenNPeGNTVklmQ2ZkNllOdEtrM3RrS1NQb3o0N2VSYk1l?=
 =?utf-8?B?ZWpic3RON3lPY1l2VGR5QXJjdkIwTVlVcTRITFM0dHhIRzkyeExaVzZXSWRp?=
 =?utf-8?B?cDR5SUNvR2lLY3ZrUVRxKzdGRlRlZktSYU9kRUtOQzZjMzdSdDZFS0YzWHhY?=
 =?utf-8?B?a0tLdXVQbDcwQVRtNzdtZjQyOWJjVjc1YTVYTFRwcWZUVlpsSHRwNXZjcUN0?=
 =?utf-8?B?dFNReEl4eGxLYTVxdkhIRitCQjVHdWI1L1N1NC9hUllCVEw3RVJicFFIMHB0?=
 =?utf-8?B?Q1hrVkZieXFPMGJJVGNCeWdqdlRZYVc4aU1wQnlXaWVReDhGR3FKb0hiaVBp?=
 =?utf-8?B?NHRhRXM0Y0FxSHc0a1B2SVFaaW8vQ3ZKWUF6eGVCT2RaZGZqU2lWOVRyUkRy?=
 =?utf-8?B?M1crd1czQ1RSYSs2SC85Unc5RkhiTDcyL0R6RkJJUnNRSzU2ZW8xdWlucGh2?=
 =?utf-8?B?aDIxR1d2NXNSSVpsYUppM2lhQnZLSUdXTVVyb3dQR2RucjN4QzVWYWVybVov?=
 =?utf-8?B?d3dLbGsyZTVUclVCY09mRTdBbkFxTWF3R0hZb2hnYUVxalhSRGJoM0Jicjhy?=
 =?utf-8?B?MTVxZFJSQ21adkxXYnZoMncrZ0pCNUVpVDVyUXNSVG4vYjlDTy9UaCtqTjBM?=
 =?utf-8?B?RWpXbWFibldjcU4rQjF4eG5IWFpWN0k2K3ZFV3YyQnhKa2w1dUxnWVllMHRR?=
 =?utf-8?B?ZlVvZ2NyQ1UxTm94MXFkYjczZ29BRGJEL0dKR2FpVHJkM3grQXBHa1R1Umpz?=
 =?utf-8?B?VzM3eDB4SEdCeUYzK1ZBcWlWRk5URU5Ia1dsUzFoaHdkYkVLUGJHS2RoZEZY?=
 =?utf-8?B?cjNvUHcxZm9NZkk1eTBDWUF4Ni9MS09VbklBSXJOZ05DN3o1OStFV3NDMUdt?=
 =?utf-8?B?MzllYWhlTlgzaFJvQm8rVEM5RHV3MzlIOUw3VTRNM0NGSGhwVG8zUW9rQ2g2?=
 =?utf-8?B?eDJHT1dybWsxd0xuK3R3cXBqOXp4bW80aGxIQU1CVmRpK1M4Z3dET0ZrcEo2?=
 =?utf-8?B?aFhUTk1TSitDQ0tPeUlwNkllQkhuMUphTG9laW53SGtSTmR0SC82ZGZmUWwv?=
 =?utf-8?B?eDVhTkxoYXo2bjZ5cjFVNmx4QjhoSTJtYkI3TzRRWmdqaWlMVjl6WjdxRW1j?=
 =?utf-8?B?dHZjdVZqSkJWOU4rNUJ6SXBDTFJKaEdKU1RMcXJ4ZGtrakZwOUZtK3BVSWpw?=
 =?utf-8?B?WGQvbm91bGVCdzJiNkw0U010eVR0SHpZOHlxV3FJVitCNFNXeXAxN3lhM1ht?=
 =?utf-8?B?WjQwUnBlcHp5NW04Q0dHbGhLZ0pmWnFoaDVDY3EvWHUwQVVGZDFVT0g1OHdV?=
 =?utf-8?B?Y3N6TXNwZWJBOUNsdnNOTDc2ZnFKeU9FVWtBOUptemhjM1Vib1BYQjVpSGY2?=
 =?utf-8?B?SnZncnh2YVpPMW5IR080YlNPYUJrc08yYnV0N0h2U2hrK2lieU5RQ3F1dGRu?=
 =?utf-8?B?QTdNZEVoc2hrdVBnaDRrTDJLR1VZV0NQNHlmZlRQTGpWZlFpN3h3SlhLWUVp?=
 =?utf-8?B?czh1dG9NR1BIYmRpeWQ2Yk9QUXBaTEVvYlA0bXJRa1dwVi9OSHFnMmRHRlNh?=
 =?utf-8?B?RzFaYkdJcWNMOVZuV0hRVjlxR2kxS1RtbU9GMWwzZFZMcnlZVGJyODc5OWNP?=
 =?utf-8?B?U2lhQTVpY2w5Qmx3SWwxQ05DRkZ5WkVsV05RSmRTendiQVU5dWJXL2VOdWQ0?=
 =?utf-8?B?QS81SDFJc0oyZ0w5TTJCTUI4TUFHa3hpWXNVTy9TQ2tyeUtDSGlsbmVJZGQ3?=
 =?utf-8?B?ejhlem1yK2p2ZHF1MnEyakFQMEhsWkcyRmMvRVBqMGFzWTlMZGFKODJYcVI3?=
 =?utf-8?B?VHAzbEsvMHlKMjhCaU9sWlVBL0hxb2NzNWoxQ2JVbkhzWlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clBCZTJBVnN5L0xBTThLRENPa1JyVFNoUzFBa1ZIb1RONmo1dEw1U1E4cUpk?=
 =?utf-8?B?MHpxMTNRZWFyUWpBTktwa0V6MGtGMGNTZ3pmd296NTY1dWdlb1dHVzFNVnpJ?=
 =?utf-8?B?QS9jdlp5eGkwQnNEajZUY1hrK2xicHZwcVQ3MmlxajU4eW1lQnBOYWE5VWpJ?=
 =?utf-8?B?RTVna20rc2c1a0d4VVJGU0JRUThScXdDVFpPMSsyUmtON2xyejBWSCt1RjlJ?=
 =?utf-8?B?QmhrTU1hTFBVa2hHK0xPRDdERTJNYjJ0aVFnYU5teExYZ05RajlzNXhzMUpW?=
 =?utf-8?B?VlVVYXpnTHZLdlVNMGZyTWxxQzNLV0ZOczd2M0FUVFNJZ2dGdm5ZMmFPV0px?=
 =?utf-8?B?TW5ZaVpORmdkaFIwejNrVVYzZDVKRmo0QmFqcEJYSnB6dW9tM1hHVm1pKzB5?=
 =?utf-8?B?SXRRMWtNVzNOa05QNWtCNCswakQybkFPbkR6RHBJY1I1ME5tVFJtY1gxS0VL?=
 =?utf-8?B?TmZ5ZURoRnErSXBWS1hzTHk0Wk9xRiswN1UwQWljaElYQ2FSaFVrbVBJUnd2?=
 =?utf-8?B?V0lnS3Ixd1pnY3IyUkVxck9rd2tYMzVyZzNYNUdHdmkxdmtPdkdkTUJpbVFD?=
 =?utf-8?B?WVY5YUNuMzJVUnVTWEM0dGJPdnNjUzRmVDJ0WWsxZG5mK2xNTUJyYmRyTmxB?=
 =?utf-8?B?RDBpTFM4eGM2Vi9kMDlGQlcrdmdkTzczN0JZMnNiM3VGenpGQUpKSUl2Ukhn?=
 =?utf-8?B?WHVXR2svMXk1Y2YzSm53TVNlM0U5MlExbGJPSTlCcHRQQkJLY0RmTVBKZVR2?=
 =?utf-8?B?MDVjUmk1NXdJSmJlZTZFcXVzZk1TaHpHVjd6Qzkza01ZVXUrQlBZVzhpZ2tV?=
 =?utf-8?B?cUEraFVBUm5maFdkK05qQ2JFeVZmMEFnR3J5V2RZOHljSlBRNkRPYmcwT0Nk?=
 =?utf-8?B?elZ6elVHU29tQW9sL0pBRHFIc0Y5VFNNWjgyNHNNZEYrdkVPT252b2MrWnlF?=
 =?utf-8?B?NmxhYVpmRlUvbk5MNDRmM0huWTRCeWUwOHJoYnd3eUgxT2ttN0pGc2tyUjQ1?=
 =?utf-8?B?Qy9iM28vRVpXTjR2U0VPR25wVU12dUhDK0J3Uk4zUFRLSmhSdHdOMmlZWHNn?=
 =?utf-8?B?dU5rUVhIRHJ2N1o3RVgrd0xqVktETXhNRitDTUw5QnlNcTZqRkp0OUoyWXVr?=
 =?utf-8?B?TFBlNWdOVXV5MmZGRytwSlRHc01tZFRTcGUwblQ5c2FZT3NXbmhGRFdZRkJv?=
 =?utf-8?B?TkJRZUMwdjV4enVodzBBVzBlMUFlcCtwN003U3daUGVXNFpZajE2VEM4NkpT?=
 =?utf-8?B?cytiNHY2R0p4ZTI2TmdVVCtUS3Z2VzRlVFBlQkZWV0FRL2RxNThjSURIdGpo?=
 =?utf-8?B?ZERTbzEzVGF4eWJ3Ylgzc2xNZ1NNRExMZGZTNGplclNvOXJWSEhXMndVUTV3?=
 =?utf-8?B?M2QxMjRJTWpZOFNHdG81UUFDcVZpWEJYWkJJWXBUQXY2RFhmZkx3bnR5R1FZ?=
 =?utf-8?B?WXFtTmVjUnBtMEVYTm9pamFtMFdYN3JJOERyUlhja2ZRb2xPUTM5bEVxcTI2?=
 =?utf-8?B?bi9XM3RVWlkzc1hwbzN5ZW80NTBoRkhDMnhvT1NhNFkxRjBkb0U5c29yeHdW?=
 =?utf-8?B?MHBwaU9WVHFpbytwNFZJK1hHeCs5Q3d2bXNiWmFvYzFOM24yRVo1a3c3U2RP?=
 =?utf-8?B?UUQ1cHRIUGxvRWFHalVVR1VSYkRKNFZHSUd5Z1B0QVNWMk1VcHNIV2N2c2RW?=
 =?utf-8?B?RDFWVDJSY2t3VEdhaW1laXN6WStEcG1DaTFRdjRNWDJOZGtGSWJuNFp4d2Fq?=
 =?utf-8?B?cGkrOHlaMkViU3ViWjFNSkhYM3N0d0lOelE1aEhSV3JLajlpY0hXMEViU2g5?=
 =?utf-8?B?c1MzckhpZXM0cmVYUW9XRlVzdHdHbUVmOWZ6Y0kvczR3eTBxTEFiVFRBK250?=
 =?utf-8?B?VXBnZC80SXUybnd4dFZ1aUNZdzlFOEZTdW44aHhRSVJVaEl6TG5uMDVKaXFo?=
 =?utf-8?B?a041U0dGek9PbTh3STc0QWZIQjN0czhyMjUxR0t2SE9iMmdOOCtLNWlsU1Zr?=
 =?utf-8?B?d3Rya2lvS05aZzNXai9XZURybVBFeHFNZmkrQm8zTkZpUmhpZGxIYUhhNm5X?=
 =?utf-8?B?WURqU21hZ0FQcUhJaGhsN0ZFendab3FGOFloN0YrNWFCSGVzR0Y0c2U3cmhx?=
 =?utf-8?B?YkhFcHllTUdlelFTQ1pxanUvSmlpRTlUV2JxcHFRNWUvSGpCNWNiN3l5MDY5?=
 =?utf-8?B?TUtBYXRCd1RvcExMN2plTHNwMlF0R3RjeGxYdjBGYzQ1aGQ4SGlLdnE4cUlx?=
 =?utf-8?B?S1BWeTJXdDZNWCtGN09lUWFYS1QwRUJObmVUWFcybGlYelJ0bDkybGVNMVBD?=
 =?utf-8?B?cGx1R3RCWVI2WVc5T3FpazRweE8xcExMejBmNWxBZlJ2VHdNbEhUL1ZFTTd1?=
 =?utf-8?Q?8Wx6YINq+PKtiILAMgLaj0UoHGletignDRzrq?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e7243-b511-420c-6db1-08de520aed12
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:46:41.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiJbp0tyhPpVO2/ldJySUFOobvF32Hg70QgUQGAmJv5LUbS3FGHS6e/jntwCmUp2RfcVJebCQ7LrZA43xGyXWOb82PmjhBdkONYP0UhgwZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPF82B3F4D96

On 2026-01-12 12:29, Shakeel Butt wrote:
> On Sun, Jan 11, 2026 at 02:49:57PM -0500, Mathieu Desnoyers wrote:
> [...]
>> @@ -626,14 +631,12 @@ static void check_mm(struct mm_struct *mm)
>>   			 "Please make sure 'struct resident_page_types[]' is updated as well");
>>   
>>   	for (i = 0; i < NR_MM_COUNTERS; i++) {
>> -		long x = percpu_counter_sum(&mm->rss_stat[i]);
>> -
>> -		if (unlikely(x)) {
>> -			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
>> -				 mm, resident_page_types[i], x,
>> +		if (unlikely(percpu_counter_tree_precise_compare_value(&mm->rss_stat[i], 0) != 0))
>> +			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%d Comm:%s Pid:%d\n",
>> +				 mm, resident_page_types[i],
>> +				 percpu_counter_tree_precise_sum(&mm->rss_stat[i]),
> 
> I haven't gone through the whole series yet but this "val:%ld" to
> "val:%d" conversion seems like unintended. Next patch fixed it but it
> should be fixed here.

My mistake, will fix for v14.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
