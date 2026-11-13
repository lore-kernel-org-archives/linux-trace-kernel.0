Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579681;
	b=T96PAJgmI4S2b2tMOnk0vRigq3ZNKf04Hdg3jPvNCCvRpurJQCQeYwTJnrnSf3KbKKGl
	 xqvKCKa11xT+M0rFt3xdMsNBrFOtHGbdE8t/tUUx9zr5MHdtqFaXKWfuzZVCUv6E7ScN2
	 FsfSASO0so6suKCP5Aw7ObvsYAK4Au9JPfrTRhYkbhffA6y8czl3aYrh2s+BqMet8N5xJ
	 RF8brJ8p2N4N3Vd3nvg3/51e1GpkFOZIsJIyB5Bboop2dj/mJK2ZsRb69G/cUSOBBxue8
	 YFoEbXyYgbA2kUn3YFJvJzBUWsDrZXwSE7yWai3i7304v4lp3yKM2GI+8dHkhuss8ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579681;
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
	bh=d4Lw3YdQYq+oj1p2tIKtYCZHPrF+4Xhxem8cGrlCsg0=;
	b=PbZ8+0mnEzaXjX8zwYlNZZqh246E6MHtyVza15+2kUVJMWeBBJIr2552O9FH7IFBv7jg
	 Oq5hbEyuMhEsnucDr89iQ4H3sVFhZHeLmLiQTCOrUik9HtDi9r5niaj5HYKwr4/46kqye
	 gPyIHoV0GC0nb8kA86cZuYf1XKBsCn+84j7jIauirf80OMTle4XZkDEdTOOv8+rmDdRb0
	 srTE9v8tdsJNmHkHKG6MmBhmU4PSE8Py4HTRKiEYbR1VyAyjBjXY0XdQlqL4Gokj6RmcA
	 C08y3l+neAEbxzhrViSTbrgEp5Qg3MDfPMwbL2/OxhmcW5ZHSlxCLef8iWYJ8nbuelg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=DIho0Mkm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.141
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020141.outbound.protection.outlook.com [52.101.191.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03577606A88A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 14:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03577606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=DIho0Mkm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5TlA1Ad5gu8wBEXqa1MliMKLe1rNGO2EwMrJCO4rJZstQ+vi9jHrXD9GbnYRZkvFvv3jHZGHJttxLPs/mpLWYjxBm/Y0NTobTirShnazubYFMV9g9JGOH3xcEpqRK1njQgWoBQxpqGgTZxFhk/+qNBd1z3eUQciKL6syLeGMvG14he3sT6jcrJIQZBmnXXzxu7j+gvDbXJMfrR1xOjMLZnn3RRwgUqy2BDR+BOgUMn8BQB68zNKSHyrWzjJR3Ons8XE2KuWE3/TkTfhKRtuvUu8qKATDdsFT8U0p6Pi/ENWB2HSqg3poECxPFbyL/9eyBW1BGNgEUwqwJrtpa8cYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Lw3YdQYq+oj1p2tIKtYCZHPrF+4Xhxem8cGrlCsg0=;
 b=k7F5olEXY+bPJm6eOv11viWDxGrBfnIYDK4jybFkdc9obPmWRB3xjH1Apmc1J7QlK/F5ZVRicfMg4szK0GWH7KnNWrw/1Ua58g12O2t87WAsfOh+cJkRYuVeYGgf2ElGpjpfBm7h8/yVTY3P2Kii5fp/hK0Pp5oDRFpyZuIAASvb0AbqB8hk5S6p5bIethtq8Fn8bYui6sFDeqkcpTFnQcB5ImcB37by4ddJH8zdZxnfRYZpXt6587yI3WrtsvF9/zFnQSE8QWvJsGn6jweCNleiDaViDmDX11rZoapVNs+U6tZjFES5d8Guu5UkeDWP/xPu5oyXzbFJ1Os2RYFaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4Lw3YdQYq+oj1p2tIKtYCZHPrF+4Xhxem8cGrlCsg0=;
 b=DIho0MkmNznOq3aeniB23IO1V11U5dVhE3jVdtK4MXJWAfr+5HkNu1djGThw6+ZKoZVZOvgJA3btMO6sOPb//SUMSoXkmTTLBN1C4CWNH34ZeMva7c5a+6vWbNde6clCRg04Cg0+x3K5H4frfZtAP16bOiN8ng3Z9BEaaRmXb2VktcTgEdUGs5gE5zZhIxlwjeVC6r54sJB0KnGWOO1BvKRZZ6JGUXrOl7nWeOMlV9QJhXva4GpkLjuFWloSNaccEmdjn8UtmKza06trMU1NNY244IHJW1ga9gHfMpSaEOIwMuuZOBwbScEYmCg5IY6xr2WKcl9gyVWBAIfufBvwQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB912907.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:21:19 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 14:21:19 +0000
Message-ID: <3a5521b9-37e5-47d2-8f72-00d205cb52da@efficios.com>
Date: Fri, 13 Nov 2026 09:21:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v25 06/14] lib: percpu_counter_tree: add lazy tree
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
 <20261111203626.95838-7-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-211801@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-211801@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::21) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 97ce6c92-a160-4b8c-8087-08df419162c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261026121527099003|56012099006|4143699003|10067099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bmVOnKWC0WgWYBCGCRew+6UFYIdSGCLTzZjICL1NYz6A61ZRlN4dQYTQX0/NlsNqmAgHbcrLR0oec1rmmDEbzJo01F/ORLs7uEW0ggqrdayOsx/31Uhy20ij7upjI+UsKRcFlXBgb2URx43gLT4qYOvfP9TtfE8EiftuJTDQPuLe4futxZwxBrubh19M3t2AWGPVLA8PuYyEzs2N1NxWUYp1dZxlBU9bezLheeBc5g0g6nqXbZvuemffQNKgXwSzUE10xM6b4C3+IRTDN7nJ1Bv2QcFkLypnNxmPWx7ICD+9Bh4+JUXL6hk+6FbbGU36kY2SWv+twynfuQrlVyC03jG8URq0gIGNaComRjtQy8yMjDOxD5PSY1yRzI2l8C6xjD3sLw6XWDUtvrh8dM6z9iLmBYNBIRhbSCYdi4YbY8F6sjTlAhdDhTrtZvqfxUu9bI+hWLa1KeSI9ojvLt9rOaWF/48JbaTdYn5L254kyclgAawmP7XwwUGQBt7oEu1lUfv78GtobgrvfMZRxtWTL1qGkUhhnIcOsoOqYUI4zKPEKUym6Xnmd/erDLupibI/KJ5gUN9OSdky0vuxulojZvKVqR+LnVp7edrPZHOyAh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261026121527099003)(56012099006)(4143699003)(10067099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ZlcUFJejRCajVmU0JodFJoU3pQNHdqYW1EK2hQL2pobmtrc3hpbkEzRXdH?=
 =?utf-8?B?cjJjMzNJRy82VVRhMmFBNDFqNFhWZ1JrdEtxUWxjYi9QaDZRUlNBUVV4Z3dY?=
 =?utf-8?B?TlNCcVAyQzdLNzlDWXF5U1FUY2YwV0lEVFJYeDJCU05qZUlKZVh2SWd5RTQr?=
 =?utf-8?B?eXJsRjl1cVhzNDBsVExBSGJ0ekVMU3JjYlNON1FpdSs5eHMwQUc4a1RqSDc0?=
 =?utf-8?B?bXhvNUVaMnowelJJdjJLMGdDSHFtVktsa05TTERTbmFSTmtwV0RBM3QrZFpG?=
 =?utf-8?B?YlZjWlFkYW1jMk81THB0aXcyUTE1RTlkaEMxdnd0ZkVoTkorUm8xdEdXenE1?=
 =?utf-8?B?SVZOaExvSC8wanVod2hEWU00MmtEaDZJNmVVTkk2Ym5EeHR5NlgzSVJaUERy?=
 =?utf-8?B?dEJ6WEZTSjRXM1FBS3ZuM3RJeU81M3A4cWNSdGdEN3RIc1dNZ2Rxb25nNWd6?=
 =?utf-8?B?RENPOW5uQVNJTE1TTzVNeHYvaEpST3puTEJqWTQxV3BGc3hPc3RwS203eUd2?=
 =?utf-8?B?V3M2VGl1SWlHWHluOWZsQVlzSnBwQVVLQUtnV1loVjB5RUlaME1DeTVsOE5D?=
 =?utf-8?B?cHpKVzR3Wm1FNGtWUU50cGRWMkh1ZG44VzFiTmZiSGhMUkREbDRMU0N5NzUx?=
 =?utf-8?B?ZHdSRFFESkd3LytrRElnSHVpTG9GcC9ZNzc5cjZFNXl1dkkxeXNGK3VWVk9C?=
 =?utf-8?B?TXl0a2dPcEs5bEw0RlR5QXk3MWNaYkErMEs3R1JPS3M1SjcwYm5CQzR1TGFm?=
 =?utf-8?B?emdSUFRNWlRPc3UyUy93RGJIaTMrMVVJTmhjeEJ4ckRwNTU0ZmZwNUZlK09r?=
 =?utf-8?B?WS8ya0JEMStFejBpR3B5QzFnaktKanFhbnF0WmtWa0hsMTQxNWt0MkRDNGRv?=
 =?utf-8?B?U2JJZ2pOM0c1VHV3T1U1TGdlYWh6Q0p6QWxHRDJKU3VpVmpWZ3ljVTRNRFIv?=
 =?utf-8?B?OVF4VUNrNHI1ZkpqMEpvN1VBSjhLU1hvaFpkZFU3bkxXbHh6cnF2RG1sM00y?=
 =?utf-8?B?T0FLMnR5S2YyQzRXZEF5T01jNDN4OVhvWjlldkZHdHVLWFpvSk8vV1pPQXBx?=
 =?utf-8?B?OVhDTFg5U3U4NmJTc0NiS2VCT2NEdE1IRGlzUDh3VEsvNU01UiswMDc0bDFG?=
 =?utf-8?B?L3pJQTlENEkrVVU0ekh6Mk90cGs1S2FSc1JhZkM3Vk5MclE3VFErUi9ZTzky?=
 =?utf-8?B?SjVGZms1bWVjKzZ0TFRJNE9aNVFncURhc25OdFEwcTliTHZiVHpTYTdnMDIv?=
 =?utf-8?B?UHN5MzdTbXV0MGJST3dwQzcxOWhsekxqWllSY05BeFBHQlJJcVlFT0hOOGVU?=
 =?utf-8?B?ZTVzQUU3VCtkNDA3RkFBNUdYUThISmowZ0dxQnMxZHVDbEhqL041a1hQQkND?=
 =?utf-8?B?WHRBdXo0QUhCd1k1QlRleUNVZjh1MmFVYkxkaEZFSWw1ZlhGbktEVEhpL290?=
 =?utf-8?B?cEJYL1FoSHExUSt0bnFpUkJPZVNvWnJjVlJFcTczZi9oNm82NUhWdjBEWFVp?=
 =?utf-8?B?cmNYc3VOU3lSWG82ejhUeXU2eUhwdzlENkpjanFuOENhVGtiMU83YktIUzRF?=
 =?utf-8?B?b3AvaVVsRlZ0WmczWFZaUDNRZ0FTdkxwaTZRWnpjbEo5QVlZSWdCNDZFaGlC?=
 =?utf-8?B?MWVxUzhEVkozVXY0TnBHUFZiTEpvTFVKdnJEUmc1cHVxOVk1Ri9WWjFDejRL?=
 =?utf-8?B?L0tNN3ErRjRMK3cvNW9qOTF2cm80dzduWUxoYXIrbFlsQmFBUmsrWWtLbmlP?=
 =?utf-8?B?cGdsOGxPcmtGb3NaSFZLeGgyWjFmRmw1UHE4dUd5Y24vRXRlSjgxZTZnT210?=
 =?utf-8?B?U0RJVHhnUnNOM3VLNUh2T1pLekFtUytvMzNURUs5Wk5FeTg5QTd2YkJwNkgv?=
 =?utf-8?B?UHpoYS85ZnZmcnpER2pmTUdPK0ZiemJPN2FZS0lYYnB2WUZOU3pEUTE5ai9P?=
 =?utf-8?B?SURRclJIMFEwdjg2cFdJcWp6RFZ1UWxmQXVZVkNyNE5ENUZEckRHZHZLUHkw?=
 =?utf-8?B?cGJoUmxHMHlqRWsxZnI2OEpROEhScDc2cXNYeG02RERBei9hcWJwQ09aV01q?=
 =?utf-8?B?R3VIbnovenFHYjA0N2gwTEZVK3FoTGVtRm1YdXNJWWlBTENKMHpzbEszK0RM?=
 =?utf-8?B?UnF3QkJFYUlRaityRU12TWNKc1hLaXdoS1VzK3hvaGZ3T3Zxd2pQVUtQU2Yy?=
 =?utf-8?B?eDA3eWV5VStneGFYcWNXalRkVlNqdzE5Z2pNYk1oUlNZWXQ4UjFJUmczckFM?=
 =?utf-8?B?UkFsZ0lvVlAwa1lBMVdKQWl0dk5XUU9IV3NOcHNsVVBZUXhRR0lwakxCQzBu?=
 =?utf-8?B?UTg5K0wvRVIwT0tyWkNzVFkxajk4bVN2VWxXVndOTDRSdnVUQkxzeUw1eldZ?=
 =?utf-8?Q?IWBBT30nIF23k0CE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ce6c92-a160-4b8c-8087-08df419162c7
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:21:19.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7QpFPZb0Z56/TBFDNaQzE02J8GE+2CjYTG2ee8HUfZmNzzrnhAxM8827JxhaIj8Xz+zG+6oDDwIghT/iv1hMHXGXKWGZdKfrhlo9lseyW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB912907

> [Severity: Medium]
> Does acquiring sh->activate_lock in every non-owner worker right after
> sh->go becomes true prevent percpu_counter_tree_add() from ever racing
> with percpu_counter_tree_activate_many()?

[...]

> None of the non-owner workers can
> reach percpu_counter_tree_add() until activation is already complete, so
> only the owner worker's percpu_counter_tree_add_owner() calls actually
> race with tree publication.

Yes, this is a gap in the test. Each remote worker takes the mutex
before its next addition. The tree is published by the time it gets the
mutex. So the test only covers the owner's additions racing with the
publication, not the remote ones.

Planned fix for the next round: only every other remote worker activates
the tree. The others add right after the release, so their additions
race with the activation.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
