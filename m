Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794361633;
	b=ykuUMOs3ks8dYix4dXpLQ4RsKTnsfLGO8wfKWNuTaV5oIY4M8EUOfTQRw03Dk4OvRrB7
	 I06N6IPNyKWMuMDLhGiiBQiEqzvQJp/+AgBS+zS5hPaR5oxjBHfSPE+fYqRR5FyqokJmK
	 VKGqzn7dnjz+KSDUHteZRJIFQL0Gk5POu1QW0lyAR3BKhkl/R6QgEtW6h7LTl73F6Xqde
	 Aky+osDpl5m7JGVIfXQXCJdTf65vlWB8HvxVh4yYGl8LXX+FHHQmHqwDEijm2DrmM9oD3
	 zd8aU/sTTbgSAPx6KxEdkeIO7h3tc+7UQ+L/gabpjIsbRnHreU3fPdnkXHZSgAQSvyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361633;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NzFQ0uLbzGAE16W1pTfuAUsZiom7Kw0ytUEYZ0qp31M=;
	b=RkknRLBwWg62Luce2rQVghI9deUGLTAlI/kBaOjVvhp5ehZETM0fhsPk7P3PIl78PhaI
	 z8byiPPMVjbk4belfKuC8MXg5fKCKURKMfavLTJ/B4urlqmJ08obHcoueY/WHKPyZtbv+
	 28tlDgRDjXbjVj0DAddYUHKM41L25oELo3duoTGo+cYRGfL8eapySvpLVr+IVGP2+RCAo
	 TsbNfh883BzKwiZiBBtEyYnfkeCBCHh/jNmWQE/mtN2vZUOInH2+x4d5s+RN3ilDdywpe
	 1zmmd1Q0ER+DISnSh9tzwhf9jdg12Jbt9s6Wtfy/B5DiuWPssNPvRJESiILDsX4SXGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=goW7FxMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.75
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020075.outbound.protection.outlook.com [52.101.189.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7E606A327;
	Wed, 11 Nov 2026 01:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB7E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=goW7FxMf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU9TSAk13vq/t8P2Kh1kf17V6BpQOiEhjVPaYlb2HsXXKwITcz5pEJYV4Z+VypfbdtBOPRPQItmC0DZy1jJ9IysxVrkgm3kVZN7xbTGmqgP+Qt/rur3WnD4G8v+ny0MIuEDXqGB0Z4/0PfZM/ez7xmjKM/TlNe8yn23EiYs+D34Wo2IBEdONKdcP1X56kuO/Nh/fd0/XdngMNmxSH2gkX6wvEcIfDW2GSFvGJVtCwEEsiR2GxgOHV45XnMzqW7baW87SjkAgSASIrzEXOmedI4dqV3hVMO8kZQIDQbHAtHqh3XyvdyJfx58pW2WM4mvZWFLZtiaIV9CU8oY3X2gwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzFQ0uLbzGAE16W1pTfuAUsZiom7Kw0ytUEYZ0qp31M=;
 b=Ci+jPR+oAqSCB68ujoMyAjwD+niNAtopWLwDMY7clugJAoTXDLDyNSbl7K78ufCsyxQ0CWNkDkIjtuKzjXHQQVLMcKPa8QtmSoiiCHKABuAk7OMkmj4wbzr8VSNh/5AeAozRROW+fH92GkJ5BogBF1H7eG/pF90gK4XcodhfTPNUk5fl+AYL/WkQ6xAyMQbWOJuOmNgikFncTcdMNfBB39U1T5NLkTZtX7kw92fQ6VMv7cL8rmtiKF/dHKUEGMdW9xJqXfAyIcJZjGIlhRzPcdq/FYpicZLMfNqo92B/P4O142LTt7URunAAz91PJjsEYO6lDdJ5SGfDnZUqk5rcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzFQ0uLbzGAE16W1pTfuAUsZiom7Kw0ytUEYZ0qp31M=;
 b=goW7FxMfbzl434hu1zww68gm7hIM63+RGFVYnGgKdDuAduj0VORx9Ca8ZlI10248ASXcaEYCRVd5Exw6rD1HNzNdTDlIJlroNev7fNW4NXk3a0u4vDkxQ6pkhMrWzYMws1r91Lea0HQiKu3b3TxX0avxg0uJnbCpeDMWgojyxPzIaNqZnjHpwJdFnSG+no9qjM2hW10HpGjYhbCIybNzMZ6M9knjVVNmIn4ViZi8tsuQcq9pigDuvi3u43IaXS+Oa8LCvGouGvrWXOUojO9BX1dqROZf7R9+pBz0wrF7WfquLFQ8frwDWCyajzD+mq8Oi3EnPthIFkKtrQ8x8IIDKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB679765.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:47:08 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 01:47:07 +0000
Message-ID: <93c7bb90-a671-4769-ab4b-8c16c195e22b@efficios.com>
Date: Tue, 10 Nov 2026 20:47:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v24 00/10] Hierarchical Percpu Counters for RSS
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
 <88a96126-11be-41cc-ab0d-372d32189e79@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <88a96126-11be-41cc-ab0d-372d32189e79@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB679765:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5b19a5-03cd-4e1c-44b0-08df3f95b1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|6133799003|261009221227099003|3023799007|56012099006|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261022113327099003|261022075727099003|261022105027099003|10067099003|261028144727099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	N0SAQB+06JrZEVmdmsdmx9TZr5jQ9sEjprBYcLeeWnA5WRywfmqjq7DW5shZQ6szkn8V/RgxtBHwQKGwgPnYMaDUmlLLdJwIcFKBtt+okSufxvxXYZC6G/Zd6l1wXcAp0fK0xc7Rvom+bxWoDUpy6+fPl88dazuXURblyCfoU3UxEn5cU5mKAjKmOiLgA7C13R06EaHB0R0H+nXwSVF6xISnZuUEcBsqmVr4gvatEEPTOEuxdfqz/e2/xB4UiFKZ7gJ0jkqSUDBdF6Rd760TGg1WZtRckcEGhTjKk3u8RltTGHADSwKgN5M3vdpUB6v8K3fo7wg+Lg2kJ01spasQ1CFMXKqTTRjeUJnrzmch3Y86eMYg2IDnprJzi9o0jgMSpM1j3NyzXGghp3zxTus1D7QMaKoQh8z77OnNB/RQPuE5nrTra84y1u26ImpqTiAdxa828rcjnG1eIWoozi/YMQh+Hj4ayOE6mgTaap29BlKfWVHkv7BCWEJXifCmAlQXhLMkJbV2GW+zHNlJb63j4iSOdN3qDgc0Frf0CzqYf87TsOxztLK/qEHbc1oTfqSyzCf2PVE3A6qHr9I4REgIt2lJCUPZSq4ylxhRUNgHP8Of7YWboZOgvb3K2fymp9u3ZI5Eyy5kCklTH7XeoWF70CYPfA//n7BZkx2nfhfAnsA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009221227099003)(3023799007)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(4143699003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wnc2aDJWMGQxOVVzZ1BBMU8zbTRpbUIvN2V3dGZ1R1lZNldQbmdZa1ZHR3NK?=
 =?utf-8?B?bHMrK2VWdzU5ZUpmajhZbDY1d1JKcUZudVpaY0dlOGNGek1JTjBXSXRLVFVy?=
 =?utf-8?B?WXpneUhNcm9PZVpNdXdUQ1pnaDZtQ243dEVGb3FJUEJRN1R5ZklrOHNVOHV2?=
 =?utf-8?B?dXZLam1SaGJpLzVneEtSRWZoQXlUUndPWUNONFhVdVZGWVZVZnRHT3BoQUc1?=
 =?utf-8?B?dFJaaHNmZ3NHdWFpaHM2MklHWTF2cG5HcVlveG92YmlEdEpRN0ZJNE1GdjhI?=
 =?utf-8?B?cWNuZEtKd2V6bGdkZnVBdUxWYXAraWcwUm5YT21hQlI3UTY1ZGxvZm5xMWdK?=
 =?utf-8?B?a215dHNtemgrQVNhemRQV0l6YkFybzJTV2EvQ0hNaS9BVDRiQUU0L2JCTy95?=
 =?utf-8?B?QlFHU2pnVENvUVMyS2M5alRNR1FPWTJRZFFOSlVoSmtCeFNyQVZTRUZRMlE4?=
 =?utf-8?B?RHg0M2FBUzdwM01lbFo5T2pNRVpUQ0l6WWg2eFliWnFkamYxS1RPSXBFOUlF?=
 =?utf-8?B?cXhGR0VQSXZVMDdLekkwWjNEbWFiZkFaaEwyRDF2VFZUM3JzcW5PZVZHd0E2?=
 =?utf-8?B?YUhGNGp3SzRXd1ZiUEprZ0lmOGQxZE1PK1kxWXRPUDByVHE3c0o1cC9vWTc1?=
 =?utf-8?B?U2JLbmlka0ZXT0k0ejJnVm1DVE5kY3o0ZndYWFJkQzY2Y0hGUFNsRys5Z2V4?=
 =?utf-8?B?WWJIeDJ1aTRlbmhzUEQxeWoveEkrTUZ0bzQ0R3AxS2xPSTh4TURZeDFDR3Vt?=
 =?utf-8?B?S0ZJK2xYSjdyeXVKNlhjVzFkK09DZlA0OTdNejNrRllRSEx2dDNvaEs1SGx3?=
 =?utf-8?B?bmNEeFdwOE9zd0pjRDNKcnRMNnUvdzZ6UDQ3cVNmd0lUbDhGRTA2VGlYenQ4?=
 =?utf-8?B?cjJRampJdXdGOHNPVEYyMHRybW1MSllOY3pQU0xGanh6c3pnUHYxRE9COFMw?=
 =?utf-8?B?Uyt5NUY1b0xzanhrZDhjNzU1SmpxWkFPNG9CcGpaeS9wbXZSQUk2K0Nra054?=
 =?utf-8?B?NjhHYWdkVGsrTGdlUFJ5eEk0eFRrZDNVWjEvKzcwaVREVStIYnBQZm9pa3hp?=
 =?utf-8?B?R0NLQkJHNVVRSU1lbkx1TXd5bmx4bGNuNG1nVkxqc1FJQURkT2gyU1BxLzl5?=
 =?utf-8?B?MzRhZGdWN2ljLys4eXRKYlhQZDNubCtFcGRld0N3bXk2S3Y5dDlQeHlFSmls?=
 =?utf-8?B?NWx0bHJFelc4UU1xeTc4d2dESDJkbEdEQUY5bnVNT3RncVRDY1lzcit1MVVz?=
 =?utf-8?B?Y1JIMnhYTk5ubnczaVl2OFJtenBrUlErUXRhbWFYWHBkZmZlNlRjVG9BaFlE?=
 =?utf-8?B?cGxjb3d0YkFzaVB4RWpoemRqNlVockNHeHgyZEN5aTYybDFvalNRQlNMVGk5?=
 =?utf-8?B?WmhEQXIxZW5nUHdEMzZuWGY4NUI5TStNNW9OeEN1TEplb0ZTYmxlSVh4QURh?=
 =?utf-8?B?UU9MVzNPWE9kOCtXRUcwdC85MXFMMUQ2S0RoRmY0R3hjTG5PVDliL0hjMGFn?=
 =?utf-8?B?MUFLbU1OWG1ZNUNDZmFSeEJvRk9kWjRWYnllZ21vMmROMkNtUElaYVduV0hD?=
 =?utf-8?B?a3AxVFNpbHUyUyt6YVQvSENaeTVkOWQ1SWM1cjBTdmRuUUJDTFlLdXBCa2ND?=
 =?utf-8?B?b0tFaFpORjhGTTZqVWR2VFZ6SjVQalhBekJEOVlCU1ZpOWhjMFNmdTJZR3FV?=
 =?utf-8?B?MGc4MEZocXJFVHh5K2ZBVmVQMCtsQklnNjdCSFFyY3RpaktEc1d5K3FGeXN1?=
 =?utf-8?B?cjkxL3ZOa256SjM5WmZNYUpFbTRNR1BaTmpNK0Jqb1ArYnBIbXNRYzZuTW5L?=
 =?utf-8?B?QUV3ZEhQSFNpNlVkRDVXRTgraU1OZnlEVU5JUHNkcXllbk1lY2ZUQllPdFdk?=
 =?utf-8?B?TmFrdndIRmpXdTZMSk9vbmxNWCtvZUY4OUxzdmZJdmlaWXM3WTZ5M21rVmJk?=
 =?utf-8?B?Y2NodEs1dk9CeWlHcDJnTVlxeElxYkVpWEV2SlZ5eDdpYUt0Y2Z1cnMxQy9y?=
 =?utf-8?B?aDBFdDNEMkJSdFVycDNsWEYybG1kbTh4RjJHRmZjYXJPZGVyL1pIQVdrYWtV?=
 =?utf-8?B?bEZkRTRrd0ZPSGxqaWswZ0ovcGNuK3d0Q2tXOGhkSFZER1RjV3pCRVFQMTRi?=
 =?utf-8?B?K0ZOcUwvWnRWWEZ0NUtoU3ZmWkFWNXVxNFRvMUNIU0o3Q0hVZkYzUmE1b25C?=
 =?utf-8?B?MjhUYXlEZTZJMlFIQk9lZ2kvdXRCSGZhemJ2UFV2K2ZBK2FncmRrNXlGYWpm?=
 =?utf-8?B?RUxIV3pkZEs3cFZuQXR4OHR3TWVqMGlsQWhxc0VQeUhxbXlXRnZXdkY3Mjdt?=
 =?utf-8?B?MTVSTjFtOUFiNk15dnA2ODB5NVptZng5blhwY1ovbCtuaGFXdVpnWGdid0Ft?=
 =?utf-8?Q?4VXIoWf0jQW9JBXWisvj1xm8WIBA8cBqqH4fe3VtfNmVg?=
X-MS-Exchange-AntiSpam-MessageData-1: w4MEwiyPtW13qVF/qBueyW8jKqi2Q8epE34=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5b19a5-03cd-4e1c-44b0-08df3f95b1b9
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:47:07.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgG/YPWJrDov7R20qWo3FtXbs7y+49qQidxRF+LYLAGMrHKGbztNK99n2L+SgWNewnjR47w23pT/1ss+ifShF/AvQQ7t8iVGyZMryqeMpbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB679765

Subject: Re: [RFC PATCH v24 00/10] Hierarchical Percpu Counters for RSS
In-Reply-To: <88a96126-11be-41cc-ab0d-372d32189e79@kernel.org>

On 2026-11-09 15:35, David Hildenbrand (Arm) wrote:
> On 11/5/26 21:36, Mathieu Desnoyers wrote:
[...]
> I think we discussed other possible applications (IIRC Michal expressed concern
> if a single user is sufficient motivation for these additional LOC). Did
> anything result from that discussion that is relevant to v24?

Yes. The next round adds a second user: the tmpfs size limit (the size=
mount option).

Today, each page charged to a tmpfs mount checks a struct percpu_counter
with percpu_counter_limited_add(). That check takes no lock only while
the mount is more than batch * nr_cpus pages below its size. At 384
CPUs, this is 1.1 GB. A smaller mount, such as a 64 MB /dev/shm, takes
the counter spinlock and sums all CPUs on every page.

The next round adds a limit counter built on the tree. It keeps the
limit strict, without a lock. fallocate() of one page at a time on a
64 MB mount, in a 384-vCPU guest, in thousands of calls per second:

   processes   before    after
           1      209      481
         384      124    53944

Mounts of 2 GB and above lose 1 to 2% with 384 processes. These are
patches 8 and 9 of the next round, right after the RSS patches.

A later follow-up would use the comparison functions for the OOM killer
task selection.

[...]
>> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
>> percpu_counter"), the RSS counters are struct percpu_counter with a
>> batch size of max(32, 2 * nr_cpus): their approximation error grows with
>> O(nr_cpus^2), up to 1.1GB per counter at 384 logical CPUs.
>
> Okay, so that's a per-MM problem, not a per-system problem. On a large system
> with many CPUs I'd have said "likel we don't care" :)

Right. The error is per process, so a large system does not make it
small compared to the process.

>> /proc/PID/status, /proc/PID/statm and the OOM killer moved to precise
>> sums (commits 82241a83cd15 and 5898aa8f9a0b), but the other readers
>> still use the approximation: the RSS high watermark (VmHWM, the
>> ru_maxrss reported as "Maximum resident set size" by /usr/bin/time -v,
>> taskstats), /proc/PID/stat (ps, top, monitoring agents), the taskstats
>> RSS-time integral (coremem, sampled at each tick), NUMA balancing and
>> the mark_victim tracepoint.  On the test machine below, the
>> /proc/PID/stat RSS of a test process was off by 17MB while
>> single-threaded, and by up to 134MB with 64 threads.
>
> What's the resulting impact of that (temporary) imprecision?

It depends on the reader:

- The high watermark keeps it. update_hiwater_rss() stores the maximum
   of the approximation, so a temporary overshoot stays in VmHWM and
   ru_maxrss. /usr/bin/time -v and taskstats report that value.
- The taskstats coremem integral adds the approximate RSS at each tick,
   so the error accumulates.
- /proc/PID/stat shows it as is to ps, top and monitoring agents. In
   testing at 384 CPUs, it was off by 17 MB for a single-threaded
   process, and by up to 134 MB with 64 threads.
- NUMA balancing makes its decisions on it.

>> Precise sums cannot fix the high watermark or the RSS-time integral:
>> update_hiwater_rss() samples the RSS on every unmap path, and the
>
> As a side-note, I absolutely hate update_hiwater_rss() on the unmap path.

:) It is also why a precise sum is not an option there.

[...]
>> Patches 1 to 5 replace struct percpu_counter for the RSS counters with
>> hierarchical per-cpu counters: per-cpu bytes carry into a tree of atomic
>> counters shaped at boot from nr_cpu_ids, with a fixed batch of 32, an
>> error bound in O(n*log(n)) and no global lock.
>
> How does this interact with CPU hotplug?

Like the per-cpu data of struct percpu_counter, the tree is shaped at
boot from nr_cpu_ids. It is not reshaped on hotplug. The residual of an
offline CPU stays in place. The precise sum still reads it, and the
bound still holds. Patch 1 has a "CPU hotplug" section on this.

[...]
>> Patches 6 and 7 keep the RSS counters of single-threaded processes exact
>> and without per-cpu memory: until a second thread shares the mm, the
>> task running on the mm adds to the bias of each counter without atomic
>> instructions, and other tasks add to its atomic bias, both read in O(1).
[...]
>
> What was the particular reason to special-case single-threaded apps? Do we
> expect them in practice to really be that RSS heavy+dynamic such that it would
> matter?

The main reason is the cost of creating a process, more than accuracy.
Every exec creates a new mm. Upstream allocates per-cpu memory for its
RSS counters there, under the per-cpu allocator mutex. It also sums all
CPUs when the mm goes away. Most processes are single-threaded and
never need this per-cpu memory.

With 64 processes spawning a static program on a 384-CPU host, 19% of
the CPU time goes to these allocations and sums. Here is posix_spawn()
of a static program which exits, in a 384-vCPU guest. The gain is over
patches 1 to 5, to isolate the single-threaded mode, as the median of 3
to 5 runs:

   processes   gain
           1   +22%
          16   +26%
          64   +42%
         384   +22%

In UnixBench with one copy, Process Creation gains 15%, Execl Throughput
4% and Shell Scripts 6 to 9% (one sample each). With 384 copies, the
results are within 5% of upstream, in both directions. A kernel build at
-j384 does not change.

It also saves memory: at 384 CPUs, a single-threaded mm uses 1928 bytes
instead of 8072. And a zeroed counter is a valid counter in this mode,
so a static mm such as init_mm has working RSS counters without setup.

>> Patches 8 to 10 are the tools to tune the tree shape on other hardware:
>> the percpu_counter_tree.arity= and rss_stat_batch= boot parameters, and
>> a KUnit benchmark.  The default shapes were measured on one machine,
>> with up to 384 logical CPUs, so results from other hardware are welcome.
>
> Hm, so that means one might have to fine tune these toggles to get the best
> performance? That's a bit unfortunate.

They are not meant to be needed. The tree shape is chosen at boot from
nr_cpu_ids, and the RSS batch size is fixed. The parameters and the
benchmark are there to check these defaults on other hardware, because
I only measured them on one machine.

[...]
>> 1. Is mm->rss_owner acceptable, or would you prefer current->mm == mm
>>    (without PF_KTHREAD) and an "activated" flag?
>
> I'm afraid I'm the wrong person to ask that question. I'd have to look into the
> details. If it's just a simple member, we likely don't care about the addition
> memory footprint (if that's your main concern).

OK, thanks.

[...]
>> 4. Should the rss_stat tracepoint report the approximation, stay
>>    precise, or report both?
>
> No strong optinion on that. Do we know who uses these and for which purpose?

It was added for Android, to track the RSS of each process and detect
memory spikes: commit b3d1411b6726 ("mm: emit tracepoint when RSS
changes"). As far as I know, Perfetto reads it. Martin, would the
approximation be fine for your use?

>> 5. Should the tuning tools be merged, built only with the benchmark
>>    config, or dropped later?  Who could run them on non-AMD, 4-socket,
>>    arm64 or POWER machines?
>
> Is there some way to have it be an auto-tuning instead of requiring this tooling?

The defaults are already automatic: the tree shape only depends on
nr_cpu_ids. A finer heuristic could use the cache topology. I would
rather get results from other hardware first, to see whether the
defaults need it.

>> 6. Is tools/testing/hpcc the right home for the topology test?
> Good question, I'd assume so.

OK, it stays there.

Thanks,

Mathieu
