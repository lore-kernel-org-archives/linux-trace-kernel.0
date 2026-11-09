Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.127
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253236;
	b=XA5oKa+g1By+3Yyh57681ncBw3NjEoT06L/Cpz3IylQE9XRKaTT4uZKa7raSoiYWwQXZ
	 F7v0/N3kCFTRjbh8NxLuQLLOYBa7hRzU1tW0WUh3hfhxW9LkHWGXqYSV7N9wTfJVABuqd
	 q8ve0ws2nIYJlMxkYZL/hVGwjaz9ra7ECJ1d/PdqU7C1HgZzBTVt8IPMHfhl4byBOLsl0
	 mvz/49t7eD2DvEAmRs1mwFz+sUT1QN5yWfNF82o8jB3CEuRnT7TRTwXsHp0rlTY3rsz84
	 mzHDjaVcdsTqrw6Wg44RPXgr/1eeZLB8GWB1XHaW7UahKdJ93F/SDSNE5LdJGCzASzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RvCbk0EPqyCQgZHSq6ATxS5i9bQZpF1B8G1/xSTGGP0=;
	b=b2eh7BWzBR1hSxJ+/9NxadKyI7hbq96f+6WaYA7pQ2kTYV3y1NbPUhnXYml2ZlBiKVHB
	 GvIkoWxdiuEk1pYRWOD1S0SOzVQqAlqaZiw2EXEfV3yreNwaM3Nv/e99GloP1oQVgmi2c
	 +NF6VrG2dh2wgiSUIHUBuC/sghOaqZPBvJf0KwfL0aIOKJxLrn8tmOWR/cCkZvX/q6yjV
	 g+ci3Fqc2XCxezG/G+JhIGro3oXNfJR4f15pvFxCAV5IKwUTBfrJeEPVH16luYt2sYTPG
	 EP7D3WODq+jH0uCSApsnyA66KEal4IA9n2ZX7TFT59FSX5nHJ2pqm4+WxVcn1HSYrUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=XxWg1x6J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.127
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021127.outbound.protection.outlook.com [40.107.192.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F274606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 19:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F274606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=XxWg1x6J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTZZx3gEyUPzOD7vh60sL/sGmCQdQ6WpAmAchVNCFuWe9SNR1jtrwQbl8x0I+s89sW/M8TUk0v3eLOPF3e+MYhHeks1b7exbHlMHGQYzf3RoJe0ApmOKbc1WGxHxMjWh/q14peEK8f6x4lcLKOmS3n/UhgDM9WShhTeuYxGIkXbZrVOVH4sJE2nuIOutL4jwlwFaCUK+vJV2h7JvoK6cMMLkdYlT0n2ah/bHlU6EbArUiBtyfl2GHihLXQvjytc7poD8Tzv16bKbMuxgsWPNjN0ETy6RyuBFIqLrorWHpfDR4FJtqLJYVh3lyTNlZXFaEOE0FcWC2/aJsjz6phvQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvCbk0EPqyCQgZHSq6ATxS5i9bQZpF1B8G1/xSTGGP0=;
 b=xABA1222xOmngRqEPVz4PXqcWwWtgcPRucWQAJ1czEyH4NUX5m/JCRvlPxtFr05QxoJ7ZwGj7EAdKMPGT8xhFCm5XrWPNbNV/2N1n3OAJFb4LkArgkCQ6BUGox+MB83/iYrpehcZJw4+j+fXTxpWbhLDuuBiwrh/WnoytrjmCg1mBZ4RiVFWcSkIg24BPN0/TpzJg5djqC9DI7X4hRkdPJUkra/IqNMCQtp52J2zmXTkNMAWhBfuWO0Fn7ZVNBaektOso/mjpauUfwmdZ80HK2+H/KuoKdbwZfBH6E1MJLIUwsVcMP9USYZO4neelLwfsgfF4gK/dffc/npjpwl6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvCbk0EPqyCQgZHSq6ATxS5i9bQZpF1B8G1/xSTGGP0=;
 b=XxWg1x6JuqfFduzrmg9mQjdDAiXuQ+cUxTjiijFX3YJ7HxUxlDU6oVLRP88agDUcHCBjKTrgHaERjRZs/eNM3k5UE9Nc8IVAYYYAfIfQLviru3GmEU6qGlH9WEoRrY/F8lRjo/Mv8AXRXgfhl7ZWq5gA4mF5pu1JMF6P+XKMSTArxTBnJvtOISrSQWKGNaDqBmx4oNQBHrmBUOg/5w4fx/ybclJusebRCC5+pVKvwclqppSQuU5zOIsodRssk2mZFiLHYxeFGytA4fE8yuIYp7rS7fQpg3npemnJpl0x8+HGeXWTkvVX+c3vk3qzB1RT8enAB0JSAQpvsl3+gZNfew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB261024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:19a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:40:32 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:40:32 +0000
Message-ID: <c18938e0-3588-4141-8974-eae43697c531@efficios.com>
Date: Mon, 9 Nov 2026 14:40:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v24 06/10] lib: percpu_counter_tree: add lazy tree
 activation
To: sashiko-reviews@lists.linux.dev, David Hildenbrand <david@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 David Carlier <devnexen@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Oleg Nesterov <oleg@redhat.com>
References: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
 <20261105203639.1459524-7-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202244@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202244@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::27) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB261024:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa44048-4124-4cbf-726f-08df3e995136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|10067099003|4143699003|5023799004|261102123227099003|56012099006|261021121427099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	CybX7EBvanb5cIVwzx9hEG3UtteWyHGNa+XxRPGPGxgZdfkxvC5VvV+lyBN+mA+UBzX71Ga7+qm2MJrDp/AKPbzST0VaEJQFUShBJ73HRDcF1+e+Ce9/5CkvhRa7LjeCx+QPr7dDwrEEtU3d0fPR1f0nSyVI5dhYkuODN4tt7lQBbo/EWtca5jePwEZIbz6+hhcfPxDJ6INdqz5qIo9Ylr7R0Hq1vDLqS2NFKOdumxe0QjokrLevhz2O3QLzkhM8Zb+8xcBGx84TYWBGVRXWPFl5TsbJUjAsoY6jMlHl6yPJIwxI/JZm/NFYPbw7xNE7w3Pvl1QI8/2W4F1X1YrniytusCVEF3OfaRSvzw2bT+3L8kuoulxM9kbX6OfpmyZTmusXL5JDfehbgBK9vHkQmqwr5EfmI/HkP8Uh8i/wWRq6HZjE/vVbcf1tfB45NNLPu3aqkO3liSzjfRA5dktdtFNEGzxpBY0LP3xKXr3e9X7ny+QPS63xqdAcUVA/arPbBVCGDKyFP0HumUxdrKlZSFOvAr4Z3wM1QAZIUon91nSkvbD7EVjanxGFyNOeU9JTJNSp6T6kp0QSqCwwAi2mPLoWwK2IagBDwF8jSu6ngs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(5023799004)(261102123227099003)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhZZjlwQzA2MG5ISDhBTzlUVElLQkI1blRpVXU2akRKK283c0tlaTFNTGtT?=
 =?utf-8?B?Qng0dEJqeGJTSDFscW5TRDFNV25QM09BRjMwVGwzQXQ2TnJZbE9iNnJWQnFC?=
 =?utf-8?B?K0FFTUR3VDVxTUl6U2NleTZpeVZkZm41WDg2amJhVmFJM0tMWk5kZ3ZOd1k3?=
 =?utf-8?B?eUNZcXBvUWNJdVQ2dUFPRWtBVk9XQUc2d25NZGlxLzlsZXUydVBWS1FBUDhs?=
 =?utf-8?B?cXNWT1dkVUZuMzRkbThkQ3R4TGF4NHlZT2VnUkUxTDFpbGxtZUlNRWJncFJz?=
 =?utf-8?B?OUFlL2Y0cjI5ZjlnZER1aG1keDVkT0hUSzBjVUY0NHczSlQyVTJrSXhLSFhk?=
 =?utf-8?B?NU1TdGVhTlpBbVJwOEozQno1VmwrQnFvUGw1bVhiVzN1eTJzWEhCLzFBVlR5?=
 =?utf-8?B?U0ViZ2xncDVHQ1BIdW1kb3JTNEhvNzQ1SGVrN0lDY3grWWRsLzA2NmRacm1u?=
 =?utf-8?B?aFFIdUpubUdhSnhsRS82SzhQVStDQnMybmFFMERLSitXWVptU3grU0NsUmt3?=
 =?utf-8?B?bk84SUlWUU1LRnJpYXJhWmhEUjhKT28rdHhlZmNMYnM3TGRieGg1WHRnNHQ5?=
 =?utf-8?B?dW5TZFJOTG5aQmVyVlNXZy9OditsemlBZHgyK2F2Nm1LMjA1ZGRzV255bGJK?=
 =?utf-8?B?dTBycEg4cWg2dVhFRlJsVXArejZsMytVd2FnWkZVMHRQT0Yxa0lxcGhMQjdv?=
 =?utf-8?B?ME9Uc1grYmRYUGptY0Nqayt2c1hhZW56ZWQ3SENxc2dzZHczNTRyQnRESVZC?=
 =?utf-8?B?VTBSRC84bS9oZE42VVpkQ09ONVNNSzR3cTRHUEtzV3loK2ovZFV1SEN0OXNn?=
 =?utf-8?B?NFUxUW12UzJKLzJsQ1ptZnJXYy9QOGtBbDJEMEw1ajIzVHZzS3J3Z2FPeita?=
 =?utf-8?B?WlJmUElUS1dkM0wzZGxhQW9tUFJvcVllSzF2Y1JjZlJzN3BLOXJ4TWtpbFRj?=
 =?utf-8?B?bkw1THZzRmo1S3VmSWVQZksvSER3OWpxbUxZelpCMkJFd0hOMnVNRmRCd3lp?=
 =?utf-8?B?RnVRWGFVMENyaE5RMHBoeVhXYU1rQUJabzc1R1dlMnJpQk5PLy9iSVRpVHkw?=
 =?utf-8?B?ZUVFTEVEQXhqSmEvLy9CY2x2Nnc4UlpiNllKaU5YSklrcHJrUVlWWStsdUlE?=
 =?utf-8?B?S3dHZU9XUHltUnJRTHBxVk1BQjFkd0dSN0U0eTU4RjZidVFkalR4d2pxdE5U?=
 =?utf-8?B?Q1JqeWhSb0JLbzBsYTNUSiswdmRZaTNJSXJGNnpLQ0xUcHR2V211YjBab1pD?=
 =?utf-8?B?NFBZQzM2dmlrMGI0TDJLUjVnaGE5YWhyYktRWDR1aFFmUGtNNDRZN3lGUTYx?=
 =?utf-8?B?MkcxTmlUU1dQUngyZ1V6QXhWQVdQcWRjTXZMOHVOMGdQL1MxTU9HaFRoZWlB?=
 =?utf-8?B?QXR6S3BTUU1jSy9PL3UrMWVNWEFrWEpyRkRCQ1NtQkZXUHZsaC9VYnFHZU1T?=
 =?utf-8?B?SExTT0F2UkswRDBhZ2hNVnkrN1hHZVIybzFzOHRFMzJjS1YvREw3S2tiUnZq?=
 =?utf-8?B?cG5jZTZrS2tmaENQYnhFZy84alBLSHVCSVF5TUV2UEtPWHluTHBhTlBYcm5P?=
 =?utf-8?B?NkU4U0FoOGxGV3V4M1lFSFc1OXFrNmNQNjdFZGtPVFVna0ovbFZ4VlNaaFZV?=
 =?utf-8?B?TUltaE1mZUxoMDI2NFpuMW1MeTIzZGRwYzd5YTBKVnhXZTI2YTJaOW5zUDh2?=
 =?utf-8?B?M1p0OWxEUCs3TWxiWmdWWkxqampBWTREVnhiTTRhUW9KNUd3QWtOREdaVjFE?=
 =?utf-8?B?UExXNFRmVHJhZWZRdmFwdmZ5cHBOY3h2VHRRRWV0c1B4UkdZY2Jsd3U1cjM3?=
 =?utf-8?B?Vy9EZ1ZYR3VLbnlHZTMwa2tLdC9xSGJoVUxrbThyUUptZ0dVQlg1Q2ZtYStj?=
 =?utf-8?B?RzVrbVBJQ09ka3kvOTdiRUk1YktjYkpNU2kzdG1TdGx0TXZiL0dhZlhuckhW?=
 =?utf-8?B?V0drREliZmVRc0dYemZqMjhyRG9JZW9OK0FUalpSMFRReERMTVVMcE11aDVJ?=
 =?utf-8?B?Um41UjZ5L3dLWkh6M0RqNWNvN3c1M1FBZlVyLzJsV256UmVQUk9ZQnhWT0h4?=
 =?utf-8?B?SFBoQTJmQkV4SGhpSzhrbklFMWFtaDZWRXE4YVl4V0RzeW9WMkV3c2JzV0Yw?=
 =?utf-8?B?aDNFWlBXT2lKbStPVGdrOGJKUkhmZWEwMWlaYUxTSDFvTG5XQktINi9tOHJY?=
 =?utf-8?B?NEF1UDR5TURwVDYvRzl2NXNBbFFtNFdxZko4L2hyVFVLTXJ1NnYrVHQxVWdH?=
 =?utf-8?B?RG53cnhrcUU1SE1wUG91UWc2NVI0QkU1RStwd3hRbnNZMzBvQXVkZDUyWWo0?=
 =?utf-8?B?MnMwb1ZZMlZGTEl0Ky96NFVoTDhmMWlZUUpHdzRBMzFxWXdHdGdiNWYrUk1a?=
 =?utf-8?Q?RrAI2PRSH3vMHWikt/GJNxsdrv3fuwYq5G6HB?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa44048-4124-4cbf-726f-08df3e995136
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:40:32.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDWiKtKZXcFYllg0B0enTMmJ0LuL611sQ6U250wgUz9tgYPdFo1s2Kmy3uX4vzuln/gWg9bhsjKvthpjL2ZceOoU4QttB/ZMi+xdfzSzyOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB261024

On 2026-11-06 15:37, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> In hpcc_test_lazy_activation_race(), can a weakly ordered CPU reorder the
> relaxed WRITE_ONCE(sh.go, true) before the loads of pct.bias and
> pct.atomic_bias inside check_lazy_counter()?

[...]

> Should sh.go be set with smp_store_release(&sh.go, true) (or preceded by
> smp_mb()) so the pre-activation reads in check_lazy_counter() complete before
> the paused workers resume modifying pct?

Yes, this is a bug in the test. Nothing orders the reads of the counter
in check_lazy_counter() before the store to sh.go. On arm64 or POWER, a
worker can see go set and update the counter before those reads
complete. The check then fails, although the library is correct. x86
does not reorder a load with a later store, so our test runs could not
hit it.

Planned fix for the next round: the test sets go with
smp_store_release(), and the workers read it with smp_load_acquire().

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
