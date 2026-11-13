Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579627;
	b=yDjvYCBdvGuM0a9ussJqNzltnge4a41j77EZyJNPMRbDkB/ycAskaUFTF02B/dEuayf5
	 a25T4LPkWKSvVr7NGVvdgUNPi0JHAwXK4vRIzdbbirmSplxofHqCAFxa0W3QRnUf06wEs
	 bOTyMMj3Ifbq5zNinSNAL5q6QNO5mRXItNfZe0OjYItZyamXBQz5FrijmwS/zScrOg4IC
	 jxhqbsZqsDtVE2SjFQR9fQ0wNlLC6Dhx6Lvo80V3DU92dOmKEL1PGiTiDs+smMEEh/EYR
	 wcgmPSuAerrtVZk5ak1koOpQRfENjgycwGbUUflUtndu+vl7d6DCFYa34lR4eYQ4+4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579627;
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
	bh=vlj1VHIvMIhokJ0S/I4jje3LcJk4c5K8IdFpClvui20=;
	b=CDozWbqbHtyX8ClPwho2gsrY6dSkUfvnq16RCZx72+RpdQ9k/JSI4NWtdLzhIeq0XpfY
	 B5oaDjfpORuFNaBZhccqbC9IQrIoCjBh6aZ+M4m+EALToH+btXZVWH8t7mBHQkIK6H693
	 Jk2qBm296XbRoEP0Jt6EJ1QIcdSXpmZNF1fuT57dd5zsusseACQLd5Pvb1nSkva5TRhNP
	 za9XwsDJNT7iH4MSVpbckecWLxs73DrnVcKuTjEpZme+GLcMw2pvhGScQOs4rZZpFrbmt
	 ZHu8iu3oMzVZXmVwEoN4K/qe0qPaML0+xyN3O2u4l90w6qyFJYGNPW7H1NKEjJgZbmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="Tw/oKwI5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.113
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022113.outbound.protection.outlook.com [40.107.193.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B6606A333
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 14:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 992B6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Tw/oKwI5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtFpp92fO0MPlg68DZOLLVUVkyFZxlC/b9k4tXZ2of2dLdJWzGpy6gkjaj/n4z/DbeEChJJOSLTrCioIv2WQMb5ShDUVq2sy5GvmfKEm82e8j3lMkIzkqva02AzQ0ALeg1jU8TH09JLITJCALUSw8gdOaBasuwhtHGozsy10w7v5OF2rr8n7TYOsoAXYhxkJcKTyk9Ky1hiFFFTXpA3OG7euYrZp8P3kkMxx1KIVLMq3Nx5KTzqMvVjoD6lKFKWMaz1ojeVlnb46kljwsnfnmRN72M2Fi9gRf4EQBv3Ll7q2oq0lgYOMrysTwnK1NUkcDG4Rg3Aw0x7GofnLAmCjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlj1VHIvMIhokJ0S/I4jje3LcJk4c5K8IdFpClvui20=;
 b=s4bGv3kGgq9N4dcdoPLA1ITMe75O+fO5TYv1evsnfs4Ue1aOccDtslquxH9EBVCEESsJK8spTMbp6dUT/5ID2Q7cBxidXqOJmN9uaf5Icip0vWPME+kcgniprINmLwf41Mtb2OIjpmdqfo3wzY9e69z6opijeuPSIbp5ZKeMWf+Xv4Zzo7ZMZuciUM1wRj+m56+M7jTpa2z6ed/gptuThoXRIqC3aB1N2Yixs4YQJ7RIgUUHJ4qVB3bO2Ohd96vjr1QRF1fCVrqCDpLdT129OgyNpjksY4SB23yPheuH6aE20avPONn6lWX+9chHIbKRQE+KdkuivALC0Dz9fxIZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlj1VHIvMIhokJ0S/I4jje3LcJk4c5K8IdFpClvui20=;
 b=Tw/oKwI55y8oR/Zsca5PF1TniY1Gwt4q/gxMCYrCkwQVw6GJf5OJpxcFY7TFqoZM+BXoYOh/yoA2i67CzhtpRaR/yX8rpQS9CN995GjUecYSEMdnt1Wp0a7h+QPI/1nTgfNF4VwCED8405nU4jht29vPTLSHW11vnH9WHhQovjx/Zc4rcMX/qJcWcEUcG6UWDyrVE58SFi07k/7kjPjAikPbyLreWARL389wbon3GUzLzZY0AxBk95Buf64wPxhg7WsngGKbHAjWbApbnsaV9yVA2zJu5BKmkGZ4SailtZsD3+UfxkygYjj+Vz39LArVnZ/vBTXN+3gX155Zfw9YzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB912907.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:20:23 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 14:20:23 +0000
Message-ID: <f45a858d-61c4-41c0-883f-c2465bbf3983@efficios.com>
Date: Fri, 13 Nov 2026 09:20:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v25 07/14] mm: keep the RSS counters of
 single-threaded processes exact
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
 <20261111203626.95838-8-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-211802@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-211802@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB912907:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d4e602-2d63-4b27-8ec1-08df4191411e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261028144727099003|261026121527099003|261102123227099003|261026140227099003|261022075727099003|261021121427099003|56012099006|4143699003|261022105027099003|10067099003|22082099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7wYBMrPDI8qbX2VtjdPM5Hv38JW0clz0l6qMI5DQW7YY6oLYzBRsdPYC0ir7G2dvYjWWblVRT9eHgDaZwQTFspeUrlFkXuUsfIM1NDvqYzTmHE0ae1MkDkGQkyH+Mi1OBVqfg1ZIiIXyXlYqagGbeZLafAHjeeBiADyPHTgjtm/2Rmbduun5WCKKVDEDAk4E+6VA5sGYaUZXcJqpEx5FQ+a9ig2HokkZmLRac+GQAd5yo/5Lqx8Ezho0iuSvYly9dfJrmGN+9TWPdLlnyEdAU4+dA7ZqoUVSMHGV1p42Qbls9WackOI1ZBYxENyLFWa0BXYNM2rCtPsymQYO+ujNbiCn5ErU/Bk36drmtCrG3sh89OlXq8/pAOxnmUYAZQXUXCiYD41qJWuOeNOZM1kaYd2mOAm4MrHWAn+rAb2dE9qhQsyXr7XcVDyZTiTxjQuNQW5HmkGQzPUgPaRRHZc2qzHT+xpC8vjb4dESuDqY8bLBQFHDbgoK8/kVxfNGh7RUzM6IGPFMYEWvgDI54X3ZIQwI+g/TOqaGpkv/3AAcgcJLnkIBkkB9hwgf0ZndGVOeUDm+1gXi0RpNyK7untPhZhX/A/x2hThgKNxmVsU39dk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(261021121427099003)(56012099006)(4143699003)(261022105027099003)(10067099003)(22082099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytnQVlJejdGdGRORjVQZlRkcHp6YjZkQ3orcG1TQ0VBWE93TytWdGp2S3Y1?=
 =?utf-8?B?L3Y5anpPQldjNmZ2VE9vcHVJZFhXcGE4cklXSHVGejk0TlFvN3Nhd240dFRL?=
 =?utf-8?B?UUhoTDBrM2FrV1RBVFVkOFhkcEREOEZxV0NKcGpCM3hucUNVemZnM0RQMWRW?=
 =?utf-8?B?V1ByZGVpeXdSQ1FDbHc2ZGs2cHJiQ0VSMkppazdlbko3bFRFam5NVEJqL280?=
 =?utf-8?B?ekk3MzVjNVR1WkVHUUJSWm10TFhmL0hiWTcyOEJiTmZNbWE0OXNBc2FhNFZP?=
 =?utf-8?B?R2RINEVwQlE5Z2ExV0VMUm5oY0R5bG04bmFqZkFKMmJCUmhBa25YdGRYdlpH?=
 =?utf-8?B?cE82dXFpSkhpUXFzSGNRRnJVUTh6VGorYkwrRTZkQlFkYXV4S0k5WG5jeDgw?=
 =?utf-8?B?cmRVR3ZQREtJRDBoVnl1UVJQRUwvaGpvTmFFeUZmc2Z3KytHcTVSZjJBWGVr?=
 =?utf-8?B?Tkk1eW02Tzd6dDNIZVhUMk9PNWpHRDNBQmhHajlvYTY0UFUxNkt4RnFDUm1a?=
 =?utf-8?B?UmV1cTVqSDlDQStsWUROMjF2ellWSlRhV01QTGN6L2trOURQaElmTmtsaGNX?=
 =?utf-8?B?VmhtZ0hqNGphcGFGd1k1dnZLUE1VdnFEWEtoM3Z5Y1Yzd1FvZWNsdDN3VjA5?=
 =?utf-8?B?Q0NCT09ZWE1HRTBqVFl3OGdSKzNSSnZkVWxOY1FZRnRJWDJ5SzRZeTV2V3VC?=
 =?utf-8?B?TVpCSGxCbFRxVkV5Qm0yWmxHeWpUazloekxDQm9rd0NBN2UzcjVPY1YwVE84?=
 =?utf-8?B?dy9LeDlXMXJrNit6RTJFcUc5OStvdURWbkFwY3BOQ29uTzZRT3NWNFZicXlr?=
 =?utf-8?B?dnc0RXdyQ05KcExpeEFQcDl1dmx6ZGxOYXNyZ3VRV1ZvWHZiZ0t2ZWNrQnJB?=
 =?utf-8?B?ajhjRk5xRGxHdnFVUjNWNmRQYTB2Z3BKd1JwWElnL2JLRU5JaFBZRGRZM1N0?=
 =?utf-8?B?cUtiWDhsS2h3YXNhT3BWN1Y5TkpFU2dJR3MyQUo0WlNzN1A2N2lobEMveHpD?=
 =?utf-8?B?QktUSmNqVkVNd0VYczJFZXhYc3d4M0Y4d0JPYnBFTzc5cEpVcUMySm0xSHBq?=
 =?utf-8?B?ZndnRWNSMUxiSXRCSHZqWEdISTZMK3hQbFUvbEpkaGhRdVQ5Q0hIb2xnVC9m?=
 =?utf-8?B?Q2k0MXEzZDdzV0pCTHFFM0dkay96NXY5bE8waXQzNTZON0wycHJsSDBadSs4?=
 =?utf-8?B?dTZFR0lTMlpuTzBwNXRyUzR0ZUFSTlFzT3MvS2hqQnRzbnljK2ZaZk5KZElS?=
 =?utf-8?B?WlhCZktKeGVOUkdXYXkxMG9zQ0VqdlNYZ0Jrb0pTY0VEV09pTVQ2R3VKbXdK?=
 =?utf-8?B?WFcrd0VuOFhNT0hWRndSNm44dmllTzk2NXpRN3dvaWoydFZsWHBGOVdUd1pX?=
 =?utf-8?B?RVdTSlplYjhGRUc5eHhNN0p3Q0pDNmRoYWllWjFwdlZUeHZsamhCbnR4VVNU?=
 =?utf-8?B?Q2crTVcvMkx0TEtFZHFrbzVVVVlXZnlBb2tvc2JTZ0FHR3A5ZFg5cEJJeW11?=
 =?utf-8?B?ZmtyKy9Kc09ZNmF1eU1ydTlUYldVMXZ5dlpTQkR0UUtqeFBNSDBTTENBbG5D?=
 =?utf-8?B?ODlKUEdtK1VpQ2dPUjlaTmhBemFCRE4vVHZ0R2xiNEhCUUlDVEQ4eFVtZFJY?=
 =?utf-8?B?NE41aU1VTkhGRkR3MEJIVlZCMlN0cTE3bjBFZjd0NlNzTzRCRFNOSGswM3Az?=
 =?utf-8?B?VHBjZWoyVVpibGdwOVI2cU1ZSTFjTENpSk56ZnpsZ2UwdlRUZll0RU5iYWtL?=
 =?utf-8?B?NGxUOVA5YUQ3SkxyMWdHcXNvaFNsSmZUMld4VXFWNVdZRHJpek1tc1RVaERR?=
 =?utf-8?B?WUQ2aURtMERjVUVzV3dUZUtlMldoVXE2eGticGtoSWVvcWQzZFBVOXEvTFhN?=
 =?utf-8?B?OHRzV3UyZTBlcCtCZE5mTHo2dGxRLzFyY0xRLzlFRWtIQ2R2UHdOSzI1c2k0?=
 =?utf-8?B?aUtKOUdlT0RXUkgvcXRYOHlNSjcrQVBIRnNFY0ltL1RsWXp3SUhYZDI2NnJC?=
 =?utf-8?B?citsS2x5enVLUG4vdC9FdzY2VHZMUmUyS0lCNHFUdWFCazUyeVNDdEQwT2Nw?=
 =?utf-8?B?bjJnbXNkNGsyTlV6RDlmQ215Y2JqdEpKU3p0SEFwYUtoSmxRVHRxZVVVVWN2?=
 =?utf-8?B?ZGVKcmV3Y1VQbWlTZDJUY21jdlVtdGI3YWdoVWNwalBjbFp2ZEMyODR5MnpR?=
 =?utf-8?B?YmNsRWVYeXRobjBWVW9LeVJpSXhSdENVZ0ZrRXREUXlzRy9FTFB4NUY4T0Jo?=
 =?utf-8?B?MjdZUVprSTF6T1h4ZWs3cC9CSEdTbkRMRHJ1cC95bW5UeUFtcnBhdlNNei9r?=
 =?utf-8?B?TmFud2F0UnNobjkyNWFRL1Q1Ym10ZWw4enFWL0kxcGltZ1hMWm9YU2NDWHow?=
 =?utf-8?Q?Ij2Zfw7lrPCBNi6g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d4e602-2d63-4b27-8ec1-08df4191411e
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:20:22.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtH2t8FYOg8O+6vGV5DPdNusHFOsGJ31zovDosi4q7R55TQbbvp0lrujJ5NYaWVYz8R7+CKvGDAH8egktddw1sDYRtzxlpdTk06L3czD+fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB912907

> [Severity: Medium]
> Can a failed fork leave mm->rss_owner pointing to a freed task_struct?

[...]

> If an external reference holds mm->mm_users > 1 across that mmput(), mm
> outlives tsk.  A new task allocated at the same slab address as tsk can
> then match current == READ_ONCE(mm->rss_owner) in __add_mm_counter() and
> perform unsynchronized non-atomic updates via
> percpu_counter_tree_add_owner(), losing counter updates or triggering a
> Bad rss-counter state report in check_mm().
>
> Clearing mm->rss_owner alongside mm->owner on both error paths before
> mmput() would avoid leaving the dangling pointer.

Yes, both error paths leave rss_owner pointing to the child. This was
found by reading the code, I did not reproduce it.

No update would be lost, though. rss_owner is only compared with
current, never dereferenced. At most one live task has that address at a
time, so the plain counter still has a single writer. The other tasks
update the atomic counter. The counters would still work.

What breaks is the identity of the owner: a task which does not run on
the mm would update the plain counter as its owner. The owner should
stay the task running on the mm.

Planned fix for the next round: clear mm->rss_owner next to mm->owner on
both error paths. In copy_process() this is done only when rss_owner is
the child, because with CLONE_VM the mm is the parent's.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
