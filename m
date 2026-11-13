Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579788;
	b=A8oofwcvUqQOaj+pP7xKLXiVkH+elSp6aAwGxwtynT0ig+UpC58TxE4a5/233bjxAttf
	 wec/7PrjqxqfbNVGoAB1j9v8MTzkvJ1Dq+5TnvFvAounkHeruj5eAozWmRFhDM8fHTKeI
	 MyAJn8XCd2HA4CwGw/T86ReV9wHnWfuUIyenJlFPpArps/cLc2edFSoX215a3R7Wlm5M2
	 zcsfbildr40nEE9nQM/8lONt11KEkxbskVO0CD5/zB7uUjvR8ghK72mw6N3Rc1kyYI7Ib
	 0IJoRFwJpcz3leM7A8dd2RSapisfK+zfEeZ7OCi6+HGB0ZiI94O0Lu9GDIGS8dpUfWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579788;
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
	bh=XeLDOcLmqwn4Mgr0bkG+XwfS6qej2SH5JaqSEo1Vq1I=;
	b=z4GmlLTm+XdaXB8uqH0UyPUzl5DrJpbs+LSaEyT6LC51uu1eUPufhGOWzVwblmmdr1lh
	 nWW8ZO98IT5ZenZdzUJVf0maKGfwzYVcxL+r16+r0K8V5+UKlESWqq57WgqU18AOqodFy
	 0qTozIOZpOvHhZ9/IhALYpzziNBbiaJ+5WOdryrmH5ET8aQSrWm7WkaDyISW6Dhtlzpk8
	 eYioy44cYI4hvULC3w6s/DVSAd1rSvQ6ZUlH1nWZGk8N6WxMiYPQUUzz7Q3plHnRZ7zh8
	 E+e3YXRGbItdafM7kExS7zy8qOREnqlZL83uEPf+RNYtLmGxxtqK+B9q72i7IFW72OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=H8EYQ6Xx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.122
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022122.outbound.protection.outlook.com [40.107.193.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B04606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 14:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B04606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=H8EYQ6Xx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzPW+KqP+157Eh8fL6YRU0shtP+eESFY+WWcF47Yiy1m4O2+D8M6KORF7dW+pziVdYvzci+zzvGnq2dfODbToPdY/V0KqA7lSTJUl+KFsucs2MwEVXlL/KSZsqJQOhSghpVqQ+8etbt8JS895gcm2jhJyLEfVJvVYRFqPRFy8N8AIlAgtmiMQtqvEzkfZaf060JC3Gc2WBO3mar9tUblrNvRCMyGg8Yv5trNuQ94wDdalDDnenc+ktO2BUAU4nsgA4b2eSTESorbrsN80NTiVzZUlZhBwGuUxwftwRLoQOHnr7Ekdm5xXCMTr2SxNm5fePb/K2/MoeQl70AIaCJpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeLDOcLmqwn4Mgr0bkG+XwfS6qej2SH5JaqSEo1Vq1I=;
 b=T5HlRHyF7PgywQLLQ0d27cdvMmuDJr3j5VWscJ6RHqfBnlePJNLclhnaVW+OP12nuk9y9nP7LpJuf2w2t7160kN3UsbHoR4v/9sBuAWTU4c7Fk5KVrEKf4mdxeLCOqqlMAbCYzBc4gE6LfgwkaUQNkG5RpZOSlqB+cHd0arhisbApSVf05yvrnoMRcjd+mqwm2jA38QG2AHpZFpwEJMbnTg4uSmoRp+eNOi8IOV2hXQ/1GH+IqYj3t1kdzbUD+JX5khuvdjMmWc7gQw+MQUFG1qIyxyZt1C8sxm5vSkxi5ihDn99FoqNdXYKPipo/2f7TBqsFRVskoih+g7flGwWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeLDOcLmqwn4Mgr0bkG+XwfS6qej2SH5JaqSEo1Vq1I=;
 b=H8EYQ6Xx0AJbIEqTH856+lJ659x7P6ZAhGij4yiQYrdOXGJTt6HfEIRtt6JNR7MboA8u5YpY1x+fX2T7inum3DShkFsfY9+t3ChLpIXxDLwKyEDn7Sqm5pw6V2tr4JSrLxZ3K0+IsH8Xn13freLbXbWX5wwZUgwFC3Z4CQS1HPNPHqzyCqP8U38Y+EfQdZQypWw4QLg29YxbO2tzeJM7vz+K3efW7Z+giaEGSrubrT/IsbY18RLBVaTgx5zyTJT6OhuMsVNJRsJb4PnqJK2NPLNnzbeS6bzUbic/IJ/MHgGs14JBZtNTbi+2lhEs/eu3k1fY4z6wxUFQJVpfosjq8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by TO1PPF61C4FF72B.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::64e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:23:03 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 14:23:03 +0000
Message-ID: <b33a9a59-f0e4-45a7-a112-3f80cdd0380f@efficios.com>
Date: Fri, 13 Nov 2026 09:23:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v25 09/14] lib: percpu_counter_tree: test the limit
 counters
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
 Randy Dunlap <rdunlap@infradead.org>, Harry Yoo <harry@kernel.org>,
 Hao Li <hao.li@linux.dev>, Kees Cook <kees@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 linux-trace-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Oleg Nesterov <oleg@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Hugh Dickins <hughd@google.com>
References: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
 <20261111203626.95838-10-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-211804@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-211804@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|TO1PPF61C4FF72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f00af0-5d11-415e-87a2-08df4191a0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|56012099006|4143699003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	p/hiD+m7d7zUgA6GQXrY8ynQPcmPhl3wDtIpqi2AYteFCq9zi3yIUHqrkszSS4/thkicVUq9vqUt5UR5gbl376JrQlskg9k6klKyYZ663DC3Vfv5/KMtBDqth49PBVb91aNqAMIXOolPIhFRwKvrY4oKMo/XUc/m4CZndOePIT5fMWrp5K+pKA0Io+UTFMOOACNmukSoAcIMpMnZctci12l3USW0rLsSi9ZQzp4SrQIX4qQCPbNN/arP9I2GmwKe8Gcv+wFfOnaO8urQy3n3QeTWjAlOVbbdwVXG5x5o8rajZ1VhpOtYp7Hp4PGCeJb0sbzKKKvquoCILvGtK2rw4dAe56KMZxPoSq9Vm1p4BsSebhDWc46uDA6Cg0oCS5BE+CdO6tgd9Ps8SWpyMapMphsAJBfwm+jjD0VPmtzQSvsaJKxv+EOPEkPD3YnLKGhqGJjfMbj4lXWBd2Y9S28KaAg3rCwm1yWRqFoVNjqOUkZIVjGwS5WSmSl+lLePBK+GJe73EUxNW9rGzMyDBFJuBT6MMls7KWFWjA9kdvQlvEIOvNIpM4X2WaiCoaljkDvGO4WtJIF1zr4hZl03hPMPUmPIvakg5zAhyIIdty6Vl4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUx3TXBTZk10dG9sZjA1SGFVeDFPWW9WbVdmUTJlOEdkMmIxWG1TSll6VUU5?=
 =?utf-8?B?ZFVoQWw1QllqY3hOaFZCWEp0UjQ2Q21reFlzT0p1ME1YMUdpcGZtYzZ2R3lO?=
 =?utf-8?B?NXJrUWl2Z0dUdkpWWFRvT2h4MGM2VktNZXd4bjdIL0dYNGVFcnFhcFlQRkJv?=
 =?utf-8?B?YjRSVFcxSDMyd093NytZb3dkVTZGYmpCY215VExCd0xydithUCtqNHNBajRn?=
 =?utf-8?B?YlhCUlNnWFJxVkMyZmxnTjA2bkpjUUR5bktrMlR4UUhlSGFxQThLbGY2dEZo?=
 =?utf-8?B?YjRBT20zaWt5c1RoUXhBQ01nTlNkS1NoRTh0b01sbnhtMkpldWt5VVcyNFdX?=
 =?utf-8?B?TWh6ZUhOd3VtS0RYbE5uaTBnWGtsR1A3V0hmM0dKT1JxZ2VZZ0tobDJkM2xj?=
 =?utf-8?B?U3V1UExobTVobFRLN1kxamg4SW5oZ1VIeG9aK2ZCb1FIditvZzVGdm0rT3lD?=
 =?utf-8?B?Vlc4dnkvRzZRRUR5S3ROcnorbktxZHFRbFJiL3pBc1QvQmlrUEU4YVFZTjZI?=
 =?utf-8?B?b05wb3VVdGw0U1MzMVFZZU9Ud2JJRGZsTm0zWjRLSkpjU0pXOStCbm1TUXpY?=
 =?utf-8?B?OFEyclhzREIyYU9iY0krSHZ1a2dmMmJEOGZTeDVpRm9JeFZkdExxNGgwRGNO?=
 =?utf-8?B?OWlhTFQzZGJQc3Q3b00zdXViL2lIV0pXdjlsVW13OWlRSE1jOGVHR0VYQmRz?=
 =?utf-8?B?TWp5SzBnNGwvMVU5QVhmYjQ0T0gxY1ZxWFFvaElEN3p4WTVKME5hdzZZaFNj?=
 =?utf-8?B?N2hDRzZmcmlSc3VlK0w4VzZ6SGJCdEp4QjFZcHJMRndGN0c0T0RqeTNDc2xL?=
 =?utf-8?B?SStPRU9CWHdCZXRsRHJGdTFEenFESkVpRk9DVUNSYnFvU0VEQmxJT2tZTEtR?=
 =?utf-8?B?ZCtwU3RhQVFZdlhBcFo1OEVpdlBKaXZzRW5DeVUrZ2R3YW9vRUhoczJsUXVw?=
 =?utf-8?B?VldWcTd4c3lQSjJ3QjV1RXNMTk50eEZjZVp6aTVqdDB0Y0pJMW9icXQvRzBP?=
 =?utf-8?B?c21FdEJsYmlUVklxMkhKRjRYTTBSYWlyZ01BaEdSdTY4Uk01RWg2OTFjcWpp?=
 =?utf-8?B?T1ViNHJHazZWaFNJZ3FoamJkVkhtSzlFV1BlM1lwUVVnNlZuV1VndU5IREFI?=
 =?utf-8?B?SDJ4OXJKcjh2TnZOMEdCWmwwYXRvVk5uRytFSmRmdEVCQ2lNbHFLMHVzU0N6?=
 =?utf-8?B?NTQxTnozWVQrUXEyM3VaeWtrcjAxb1lRdUNGZkx3WnZaS0ZTa09qNE84MSt2?=
 =?utf-8?B?eEx3MnNyRXZ5WnhUeTlFaDkya0J6aURXRHlRcDFlQjFlUmZ1QitQOGZlWnlz?=
 =?utf-8?B?VUlVODB6RnVHRUhPNmNDMWllclFrNnUvUFByQ0cyWjJqY2p5QmpYeGRkSTVa?=
 =?utf-8?B?R2tXeGMyRW0zSVBEU3JYSE1HOGsxdlJuMmJVUkdsZGZ2bHRTLzdZUUkrL1VT?=
 =?utf-8?B?Zll6ZStTUHZQWVc5bGl5STlBc3p4dkVINkl6S0x4SlJCK1A2elFVZnUrWmNV?=
 =?utf-8?B?MEZsQStWcG02b20vd3NLTXhwbXRNdG04VXJNSGFFVzdScCtVM3pLdUJncjBI?=
 =?utf-8?B?R1UvZjJOSEdKTVZhN3J1WWxkWEEyU0lGUVhNL3dEL3EwYXdLOWRsVkNZYUEx?=
 =?utf-8?B?NlJLZEoyeWs1cldVdFNlU0xPNzErNER2U0NjUi94c0xiVnVISko2VTJpSlF4?=
 =?utf-8?B?TmtvaHFDSW1BKzhQejZtTXZSN2xMczRuYnFGTWtYT3VZMmZBcXIvM0U1N1Bh?=
 =?utf-8?B?L0lRT3dPRE1VamFsY3J4eGRwREtpK3g3UmJXTnVWL2RITEJhMllITldTK1B2?=
 =?utf-8?B?OUF5bnFKZDJhRjJEc1F5cEFmcitUR0pTb2E5cEJLM1pTVjYzcjVqY1I2azFh?=
 =?utf-8?B?WWs5ZldsQTBUaTh1aTl4bzNraVJBVFptTW9PZ0c1M2xOOUc0YTcwS1BtcjdM?=
 =?utf-8?B?czAyNlVFaVk2MjJsS05YN2tFYXR3dzk3ckx0RVhWWlEyNkRYNWpudldzdkJo?=
 =?utf-8?B?RUVMbG52N2tTaE85cHFKc1NKNUdScmF0eFNZR3ZsdTZLelNOaTA5UGUvRkYy?=
 =?utf-8?B?c1NObVZaT3phT1FrZlVLUzVSMGNWbjRhM2ZMWGhEODQzakpUOXUyWHd1VXVH?=
 =?utf-8?B?M0pnRXZYSnA5ZmEyc1hOYXNCYnpHaUM2eER4M2ozclc3MWZsNmtVbmx3UkxC?=
 =?utf-8?B?Q3FMVnVuOFFKWVNOSlNPWDY2Y1Nsc2g5aTgyME1qakRHVEp0MWMvWFpXMUJp?=
 =?utf-8?B?NTlZUUI4VjlHSlI4UlErcG1aL3dvbGF3b3djRDE3NTVsS2JNc2VKa1RwVFRs?=
 =?utf-8?B?TENxalJXT2IvTnpWVlh1b2srbFFVeUkvREswOEtCaE1OWE9lcHRjb1ozM0hl?=
 =?utf-8?Q?KmIUHLRkR/V199Ms=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f00af0-5d11-415e-87a2-08df4191a0ec
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:23:03.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5L8PpMRjr4HJwhV32jh6gdCAUdDnrmp3Mvks8SX5ESG9ygjh7s/u5IWwcgMuqJPwtQo+jyy+s8Xh5B5oXvxnBNYBuDo9X0Ksietrs3QQv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF61C4FF72B

> [Severity: Low]
> Can the relaxed atomic_long_sub() on sh->charged be reordered after
> percpu_counter_tree_limit_sub() on weakly ordered architectures?

[...]

> This can cause a false-positive KUnit failure on sh->nr_over.  Using
> atomic_long_sub_return() or smp_mb__after_atomic() before
> percpu_counter_tree_limit_sub() in both the loop and the final cleanup
> would enforce the intended ordering.

Yes, this is a bug in the test. atomic_long_sub() gives no ordering, and
the subtraction from the limit counter is a per-CPU update without a
barrier when it does not carry. Another worker can then add into the
freed room before it sees charged decrease, and count a false overrun.
x86 does not reorder these stores, so our test runs could not hit it.

Planned fix for the next round: the free uses atomic_long_sub_return()
at both sites.

> [Severity: Medium]
> Does setting sh->target to 2 * sh->max / cpumask_weight(cpus) + 512 prevent
> limit_worker_fn() from reaching its in-loop subtraction branch?

[...]

Yes. The workers together never hold more than max, and a worker only
frees once it holds its target. The targets add up to more than twice
max. So the branch is dead whenever the target is above max. Elsewhere
the limit fills up while most workers are below their target. On 384
vCPUs, more than 97% of the operations were failed additions.

Planned fix for the next round: the target goes away. A worker frees
part of what it holds when its addition fails, so the value keeps moving
near the limit. The test also checks that such frees happened.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
