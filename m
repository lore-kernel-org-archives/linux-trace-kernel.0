Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253278;
	b=XOwQILN5WZAMydjCno7PY3StYmiOeF5npWVD0UUBZ9OGc76BDbTILOhNppCag+KGBpHc
	 jNO47/ymCO0bcddgcf+MjCZZ9Q2yHk0SE+NQ8H5Or7QwazIM1R8MDAa5Is6BhW8mEP3uD
	 AzT6faCsrMX0+RX0jizaQ74UmcjlXqLXcsbPMwxtO/4im2ZU/AwKeMojZkSc5R0hsGjXI
	 rZ7iLFT5lPAnDX6b99ntaiOm+cH5BuSSBEBYQrnubcXPBRz00OwWFzC5+Tq6PlAuJo+2i
	 5KT6vdPmUDhyfzojaEoNKazKFmIZsD6sm2q8SIt5OR1VzV2z8OCA7l1j/XHgWKE81Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253278;
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
	bh=zGiXObjqajzxHNSgI/jeYKfJRVDc/3Xvpwfjq2l+fcg=;
	b=waHCsLwmEzKiudLwz9UjWhis4WtrKkf5YtQwS8r5kWPX1d9FiBf7De/u3I0Eiz5Bhmnt
	 SOH4LDRd1ZRPByOWk1klllPBh049JhHB/3VUT2L5wx3uqwPeQxxdtsASkUZ05jzFcUOOA
	 zMKKeWA6lwPqoEPvuxjCmBBPXyAH65P9fBeO60Mbmqp8U5EmED99xzbBA9Ds5XxR1+C7x
	 ozWo5ZIsXPjZzWrV/r8gf2blQADhkpBGrO0hechDNsW69phNvjRe3NEv6Sva9eWiwTbsd
	 6k/psafOSCTwrpEyRgSXuMTsVce8AGXG3p9L1Eo1+SNMMjLARRm9Fqx+pT9XOa8p5uA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=j+txKzLf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.98
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021098.outbound.protection.outlook.com [40.107.192.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095960A2610
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 19:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7095960A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=j+txKzLf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7El65aV03cMWUn++LHHklHd4BHbz6xuNRlyhwwFxe/DksQR5jLxd0CBVF4s091qxUaoXqNwfR9c6GkFIdnpaoHW0PzNSskk0rxfJVzHNpklxxqTqm/Q8qm9uUKX95EBekL1A9dKAuKQn8/Rc/6lxtb+H9TftxBjCj6CmDPiUvgMJxpJUm5dIwGs4iug29uZ8ahjBhtIN8p6gnE4LOF20OsGYKc37f/SNpKgjA8ofBjFUt8zN5gZgdyAe8gw7ZluVJXFbqbdm43MmhbvhFzuNBoMU2AQKioY1jYDsp4JkJ4QEA731lXm3xIaYNkASTIahXN5qSSmBmhTtBd4OhfptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGiXObjqajzxHNSgI/jeYKfJRVDc/3Xvpwfjq2l+fcg=;
 b=rFsYhlPrlz5VgN0ZRUmLc2gcO1P4r0NT0wNjBdDjXOhB5XNWODwTclGTu7VJ3y+4joY1tIJPkmWhqTYSCLCGUVIoHxKlmcjkkchwoNAMQBZw1kKfPSZhN9PoJUq8ZjqkIqZginBR3Qh1b6pDlQfBEfAbybmlmrUH2srSxekrUkC9Z6BIoAXVcCOF6AIga1/m3m+lBqwVXRhFzNZ4NzYADHTkvADriS6GhEn7EAO0syhG6ssJwzXuyeDiEfUm3csAArdMVSQ28I4gKGLML66r19vcms4MejG81Fbu1I+TSd35a2xCllowiyMNbDIS7/FK61NvpQCvy2XoZMO2+XpAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGiXObjqajzxHNSgI/jeYKfJRVDc/3Xvpwfjq2l+fcg=;
 b=j+txKzLfv3g58DfV/TecTdSXTdk/3+8MoNi+2U3FWWeABmA5eYN0tGbKVJs+K1QcVDifK42nalFNrkFCAoWeLxCUvNYxOu7GDMPmoVRzau4WHxgBPh2nIoqh4JDp2HGbTsRnGXpl3tK/8w1P9Jo67za/zyuh2Z95oj2uQk1wqTnvry2tE1K/HEyR7WdePdccef537VaLnqFluk3spDnI+EtlnJlLsiAoaHS9oWIXqQ3kGffqyd1VEesrrKKgg0CSWI9gTS6e6ICdv/Uej4fhDUwkJ53tQyHXzRhvTeey6r6CYrIZSavmoP+3turCVQQQQ+Xyam1BZAei8PFwPskyvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB261024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:19a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:41:17 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:41:17 +0000
Message-ID: <b7f754d2-ddbe-421f-9672-aa1176e89dc4@efficios.com>
Date: Mon, 9 Nov 2026 14:41:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v24 10/10] lib: add a benchmark of hierarchical
 per-cpu counters
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
 <20261105203639.1459524-11-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202248@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202248@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 3dd20bf7-f7b1-40d1-c34f-08df3e996b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006|261022075727099003|261009221227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dpeRUDXmelBvE9D+2jAwONE4n/hwgkaRUVHHuy1r6mFZHTBgY630EO46O/aDI/8p/d1/fQ4IGjjzA6wl+BmAnCn1fytQMsQ0e2E1yMEY+msgHwVRTbfPB+MCqu+5BVsL3XmmEy8m9/944G2VuWyvirEbquxQjA+a5bPKJmmiVPu2YPRQxMEFIH2QWwosI5+nnujBqcNo6FCIpnPcVstQBdtT8sHaXByobhmmWJ+1+uhErU8mfqHO0rtaLjdVDZu320bttVqyQWbFCduEd0dQWrvO2KPVMPiEM6JlauSWKkO2lV+T/zU9wcQFGGGzfCtQegcUU3c0TzVctXUbETkcevv9ZpvUMoK+4x6KCZsFykqa2lZV0f2jVdS43oiCRkvLvYRqhw0Vi6V3/GYOc1gxiuSUHForkD5Zej4MkcZpjqiLEWE2SuZKjWgsLqHfdS74Wk3s55DyUaHijMI1T4udtqV3+BjMn9sDL88oPDrZ31LDafeNq3AVjvMm5FsjNkhPesgQFTN9bU6FSlR8iD54PS8vJ5BAHWl382YGJfyzvo2y3LzTDtiE4GQ2IcHBkOPpouEXPxezNQI9DHTWT90RDCATTdMmTJzVJumFrt5PCxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006)(261022075727099003)(261009221227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJCMHBULzNhNHNTR2Y1TXNuNFJDZVQ2cHJOMFVQTU53U1lYYWxZcVVGcGh3?=
 =?utf-8?B?VG1NUGVvV3Y1aGRBU3V6UmdsY3VWU1o3aE5lMzR1djdHVHZOTWlWeHpYTmdG?=
 =?utf-8?B?Z0xSdUIxZzBWTDVaWXBvdnF4dGJwbHdzaHp4SWI2UFRralhPQnBCWElRb3Bv?=
 =?utf-8?B?RmdNUDhkMUtKNEMvVTdrbGZUU0RpcE5VZCtINDZjTHdoS0NSUVdvbjlKN3Bq?=
 =?utf-8?B?NnpVbVNIZzVwOVpJTUVHSWJ6QzJMSndoNGVqK09tVE5mSGFJVHZBRmk2Unkx?=
 =?utf-8?B?SEF2V0xBNzdkOUhNZml6bDFHZGttWkRmTjVwSlhIaW82M25Jc0EvZUhVN09V?=
 =?utf-8?B?aDZLZGlHVW5Wa3IvQjF3b05PRXdGa3dJVTUyRjYxVU5HQ3BpdUZXRHJoaVB5?=
 =?utf-8?B?aTl3cWorSEowdEdyOUhCSG1mS28vTndBZEhRV3ZMeUVCRkQvRlY4eDZvVmlR?=
 =?utf-8?B?MlpGcDA5YnFKVnhSb0ExV2VWZjQ5U0pEc1NHK1RBd0RRdWdjYkRTWWtld0Ja?=
 =?utf-8?B?bHRNOG1EVGZNM0haZk1pU0VSZ1F3bjc0a09ROGZnQjRHM2x1d29ZdDMrMkJR?=
 =?utf-8?B?TnZvZ2RHN3dPMzFGeU1RTGQrYkJOS0UzanFCK05MTHRSQXlvdU5YV3RTdnNU?=
 =?utf-8?B?clpDaUEwMzJvcDRlYWYvc0I1ZTE0cXl5eGVXSlh6b0NxdVZ4UFE1RElQOExa?=
 =?utf-8?B?K3hFdlU1U2JBQ2czU2VHT05XVHB1TC83K0twbmZBeWN6N0QwUjlPeUVzRHVl?=
 =?utf-8?B?cy9mZnVrbXRCazRmTWpkeFpUcTFwbE9mazZxL1ZzRWdOMWZiU01rV3dVS09x?=
 =?utf-8?B?bUpHM3M0ajE2akZET0dsRU0xVmYzUDI2QzRSZFphNVJiMGRpck5reXNqQlE1?=
 =?utf-8?B?M1Y3OHcxdHBteVpVODJ4Ly9jcUZRcFZxL3I3T2RSeHhkNHRKcFZKa2hubWQy?=
 =?utf-8?B?YWdVTUNENWFvVTNmT2MrZW1yeWdlZ3FVOGt1dmxZOWxmbVdhV1N4VndyeWNR?=
 =?utf-8?B?Wmk2ZkJKbVhNakh4RHpwV2VOKzJvOHZmV0hlajFCRWxPY2FEV3R0dnlCWE9F?=
 =?utf-8?B?dERjOXN4UVFYTmt3MFJYZUg2MkhWTUNvT3N3S3haWm50YlRPUFdJUllWam5J?=
 =?utf-8?B?bWxUNmJKSHZ3Z2Q2Ti9lZjJ5eVNKSUFYRWNiOHZDV0ZPc0xLMHMyRjBxVld6?=
 =?utf-8?B?MURseVplVzQzdlh2VmRpaWFMVnowbEhPazVyR1B1NUdnM2FFcmllWFhUMGZV?=
 =?utf-8?B?Q2lrN2xxTVN1eFRrRmRvY2tWVnlsRm1PUGRzbGMyenB3TkZQdnRYb05tbXBP?=
 =?utf-8?B?ZlBIaGl0cUhsZWJIdU1lbXFmNWJkNk1udTVURURqamJPSXhndTZlSXEzK24y?=
 =?utf-8?B?RklEUU5TM1F2MnhtUHB0NTdhR1pkSUdrT2JrYndqV0YzajVMZ0JPZGppbHZ0?=
 =?utf-8?B?cE9rS3pDSWJCVXd5K1lxZHNaZlJOSEppT0tSTzg4QktnTlJnY3pwcCtNYWh1?=
 =?utf-8?B?aDd3TFUyYi9FeXBsSWJBUVlHVkQvTDZGV1d1VDFIZDZZN2hGS0pJNnRUdXdn?=
 =?utf-8?B?YUF3WXFFQVJiMFBLRURRRHdST0tLOXFQbVdhbGZhektlQnlDa3pHMDdYbTZt?=
 =?utf-8?B?QUtGV00zNkxIZWhvdnQwNzJpWk1DbUIwUmRxMlhmTXpoYVpUWVJIejE5aGpO?=
 =?utf-8?B?Q21RNUgwTVlsd05YNytrd0dqUGcybi8za0pnVzcwU25sOWNGVExPN0NYTUFN?=
 =?utf-8?B?cU9BSnViSGdVU0FoUVFWSWIzck9zTWc5SjNVbHBnd0l0MDRtaHV0RXRESkps?=
 =?utf-8?B?dGdaNkxkTDNZUmVyYkZLZEx4VHFFYXllcks1aHdWRUY2MmdmYUhzLzVSM1NG?=
 =?utf-8?B?SmE2RzNreVZqMkIwWUVjc2FselEvc3c3cTIwQlJUQTRiTDRmU21UMk1YTTF5?=
 =?utf-8?B?anpEZ0x3Y0w4bDU2Y2VWRUd3a3ZhMXphdDMvYjVCQUMrZkd3YjRpWTk1ejlC?=
 =?utf-8?B?RGoyRmV2TW1MdHFadERrdEMyQjE2bFJGS3k3MldzYk9YdmhxQ0h0NmZSSFND?=
 =?utf-8?B?ckprOE5BZHlFU2VOeDVqTFExOFRvL1JUbzJ3WGQxcHlPVkhVMEFicFJzdE5U?=
 =?utf-8?B?dzNYTXdMNjE1TlpLOExieGxpb2FWelFRWjBDaytrQ05XUWE2QWphcU80dkpZ?=
 =?utf-8?B?cnBuL0JsOUx6ZVpSUVk4eG9FS0xqVzVIeHFSd09kMTBJOWJac0FCWUQwTTA3?=
 =?utf-8?B?OW5QREhNMHFqQlBmM1JGUkxUcE45Q2djTkpLallCVGJoYkdRV2xLVW81SlQ0?=
 =?utf-8?B?Tm1Ra01SaDJSR2JUU1VLNmRlSVFqN3lFVktZQ3BZWFdkak8rSUZkck1lU0ZJ?=
 =?utf-8?Q?rfIcmucdFnQIURa0YLJlZeUOnWtc9eXfVYKPt?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd20bf7-f7b1-40d1-c34f-08df3e996b93
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:41:16.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ordq+wixIJkXzmnaLdMDZFeNd/DwmEx7izR/g8NP/5OCnUm1C1cT/sLjcyrpTLy6ydO8fos0ApvldMuMT5nejGUD20pFRA5Kmx9yGJdoe38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB261024

On 2026-11-06 15:37, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> As reported by Sashiko on RFC v23 [1], lib/tests/percpu_counter_tree_bench.c
> defines the batch module parameter via module_param(batch, uint, 0444) under
> CONFIG_PERCPU_COUNTER_TREE_BENCH,

[...]

> Should percpu_counter_tree_bench.batch= also be documented in
> Documentation/admin-guide/kernel-parameters.txt?

No change planned, as for v23. kernel-parameters.txt does not list the
parameters of test modules. For example, the parameters of test_vmalloc
and test_lockup are not there either. The batch parameter is documented
by its MODULE_PARM_DESC() and in the Kconfig help.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
