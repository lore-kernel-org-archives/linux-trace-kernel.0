Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021112.outbound.protection.outlook.com [40.107.192.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581E364036;
	Mon, 12 Jan 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243015; cv=fail; b=gYq6WjV0KLayD3+hsMjmE1dbF6jKsFBlPMXNUKvnFfs9ng717XCtyIYh6AVch5do4MIuTPXZAhgf2H1zPc0GZtRWdyME4kpff36l7EBm8VjK6UYOfGj4XGeI4YhLhM60ijs1bb+qFdpB182YbgHuT3Vwnw+WpUpS/KlcHX1f38o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243015; c=relaxed/simple;
	bh=plr1PKmJ43asdwmUo+4a7/DF9bVzjtOR4lTRsDXh4QQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HIXCZyNB2StUv9Yk1GICJPmbZBDsJ5+BcAwi1PzRWGhvHd8fwi7arlM0TwWJ8Q048e/PH+rhfo/PvRFtBhB5zArF+ntokaLmgWrE22W3azTY680c+qm2Ngu8jjpuvnj2eOoyB1Hh2Yq0nmYo0vA5+d1r3G3VbLj17eydsWRAERA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bZb19RJ8; arc=fail smtp.client-ip=40.107.192.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bZb19RJ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYVrFC8bHFIM1nbCVfGJ/+n4hYfSzlPQ/6qCtoGVev4LcwEAxbzX3m1YZQxQXyBdSabWsr6vD4/iK2//DnhVM4ZtfYC8ya5rS7XkyupzOaYLfRjXmY6oiB+zy77W9a7qUpprM8oY/sa5eNdTETBEWcOWt4031mlwjSwAlFwRAojmF9OPHtF8+WI34l7FJhJnSE6APcIvPM0lT3N9ZLu/jd6GfxPbxZBm1RncKR9z4XxJVK1wfTNz0T6mz8GYDcpwSFNfQpJh5PYFevcHH2GsGIUzvKudZEm03YMnYeWHTMa6AvqsO+mrp0FfxmdvJ4YzA3T8wcBhLwNR4qV0giEe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKLsWdgVRwtoybHyM41cm4G/0zyebB5vJFk7qiOF3WA=;
 b=Q0LXN3Bf6dmY6aKtGwtI2zQLP4zzV73fPljvb7IXIgeu8U0BgoB1+8jy1uDMYsdgcu7MbEf+mr3qL2yl25ud9j4yy2lVdJMRBE/0YqPhwRuTiVOHO+Q/5O1ebv/jsM+pJqCx3N/TZYSF1yI5qFBWQfceoCEglw93BK0m7KeCAa9Dc1ktwY4VGMqJ1eaq8IBhXFLMnCkl8FZ4FlNlkaODzqqVwBpI+Scb7kTJKsnsUJHyriO1ldqVkZf5iiqO8+HHsA9ps4g0xrUL3grUPupA2bwpM5OSSGmuXlT4zDRufVE6Tmz2lCnl+zWCB/GrU2ZqsSFzb1RLJsCIG7ViDD4+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKLsWdgVRwtoybHyM41cm4G/0zyebB5vJFk7qiOF3WA=;
 b=bZb19RJ8sATHt1lFQhhMKg6ELKBiBhejnPd3tkoq3IDJ8jjiQKgay63eP5a8tVDyEGDI+2HwOKUXfUP30FpeQExwk7P9w4cKI/jw+Cobyb98PVXVwhA9WTOckPHcqsZ2VwZ0/WpQ7YyWAvgM/dVJjuW4gnRbds2O8EK69sPlYE0M4C2xHRRjg1MphSCtzQYSgoCm3fGuaw+MPyYYkuJftOo4gOpyEgAXdTZ8CqIcSGeRz2M2HVP6Y+NereesR3xt8NXGcM9GnDulmdmZaKkZ7HUgl02qG6sUSE0/loGIsq22FkLNoeKO5IuseiTuPT9OzMZ+Uy8t55qMlsRUMQqsmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8716.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:36:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 18:36:50 +0000
Message-ID: <171c5a7a-f12a-46a0-b791-18e25a3c7877@efficios.com>
Date: Mon, 12 Jan 2026 13:36:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
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
References: <20260111150249.1222944-1-mathieu.desnoyers@efficios.com>
 <20260111094823.6fcb1fcceb7cfca2dd37b66e@linux-foundation.org>
 <6fbb17fe-f2b1-4233-9834-5a5020cd87b3@efficios.com>
 <20260112100523.6ab884be@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260112100523.6ab884be@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b53c45b-84e3-4111-613a-08de52098caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TklXeVduZXU0Ni9JZmRFaCtSVzc5UUkwYVdReDRKK2c1U1d6c3hpc25rOGx4?=
 =?utf-8?B?Z1RsMXE3YysyTkhod3V5MTlXTUNtZENjK0pLV2RleWtWTjB3WkpVTEx2dThz?=
 =?utf-8?B?eEQ2WjY5cy9CWmp4UnN1K0NMbkRFeGZDMWxpWjl5QkVUSlBQeTFmMlZGd1RL?=
 =?utf-8?B?Wm5HRzl3VnlqNzcyY1ArdEFsSy9RM0RnNCtYZFNxQWEvM0VsUWVVQUlMTGsz?=
 =?utf-8?B?TDJHbFdhdWVYQWNjYTRaRUlTUjdvU0RGa0ZuSFF4UUdZUU1BTnZQSldFTXgz?=
 =?utf-8?B?N2p2WW5VdmI2RFpkOTFJRHozMVROcG5TK1F1NVFWUlpVek9rVko0SXU5YzMy?=
 =?utf-8?B?OUkxN1ZvOTZabFEwbkt3L1BlTjhIbVhuWUdRVmU3U3hkS0JSbVA4RHl0YTV4?=
 =?utf-8?B?ZU1WSTF0a3ZhdjlOalB5VUl4MEc5UmNjNjBJZW1TMEdxVnl4Q3RtUThsZEU0?=
 =?utf-8?B?ZDMwYWlhdTZveXROZFJNVjNnZUh5Yy82ajBlUzdJMjduQ1ZLZ1RCVFB2YVRt?=
 =?utf-8?B?MElPaVRqSEsvMUZXMTR2SVNUamRnb3J3QkJxenVXNTRCWGtYQzFmZTRkcXFZ?=
 =?utf-8?B?UzNkMTJrcGZ4dlYvMzQ3K2RlWXRCK3kvWDFvekF3OEhzcmE4U05mQVVEMU1B?=
 =?utf-8?B?QUJrbEJ4cmRqMVM0SnkzSXYwYVhLUGhLWFRuNTdBWTFsRzJaRURSNEk1ZkRk?=
 =?utf-8?B?aHZ6N1RUWVA4R1BoL3JhSEZrZ3dyQkdUL2JxazVXRVBUbytiV2VDaHpIZWlZ?=
 =?utf-8?B?Wnh6bWxNc1RqalFCRXVUa0szYmNvQnNKanVIU1hnT1ZYQmpnZGlZeXlLSlpy?=
 =?utf-8?B?NE03RGZ3cUdaaFB4V2xLd2NKcTVKNnU5L1ZvMlY0WUhzQUtxZG1kQ2Zyei9C?=
 =?utf-8?B?dmFMME5QR0VMbTlVOTJOYUJFMXFUWW5PcmNXYXFWT0RvZUxtdlJwdmNvQ3ZJ?=
 =?utf-8?B?VnpPR05SUnBwbmNhdEFzNGZmc2s0T1NGM0J2S2cvaWlYUGxCelFXN2RBelR6?=
 =?utf-8?B?djFGMitHL0FXcVBKeVJaNXRaUDQrSHZydzNvR3kvaWs5OHhBZUVsN2R4bmhy?=
 =?utf-8?B?NmpWbjVmV0MyZXRpMStkQTFWQlJLbjdPWnlWTldZMFhibjJob2Y2TW9ENnEy?=
 =?utf-8?B?NTA5QlJLZnorZ3FHY3R2bEhzTE9lakpGSk8xaUlrYWN6UThJTmJsNE5WdVdY?=
 =?utf-8?B?UE8zMXBJUjFubHhxd01EbkJkdDNOdURhWmJkbk5pZ0U1aVRXVGZsYzFwMGhP?=
 =?utf-8?B?dysyYkZpU2FJZnRtWHBlaVVKMjBKdkliTlo2WFhFR1hja3A3djR2Y1diWXo0?=
 =?utf-8?B?UkROYmNKUkdBdEFueWFNQXlsWnlsWXNRaW05ZHNBV1pPMXJiK25lR3R2NlJU?=
 =?utf-8?B?WGNxdTNMM0QrZHhRK0xmeVNWbng4Y0hXQTNocSswSzFLWnhFbW5renRSL2xy?=
 =?utf-8?B?UU8waEM1NHFoOFB6Z3llQzB3bXM2RUlheHZzclZMSjNQYjl0RzZNek1vNlYy?=
 =?utf-8?B?THJLVWFrcjhWK2pOZ0djTndGK29MTHIxUXZPSkRYb010WVhDWXovSklYYjdL?=
 =?utf-8?B?RHBsM1FLam1LWm0xUlYxN05TOUFUSzNHckVHaWEvR0hGZjdqY3dIQlFWMEFW?=
 =?utf-8?B?YmNNK3lPTWFEUFlFU3NsTUxDdFRQalpGdVBhL2J6K1VTRkgwbk0yamorek1L?=
 =?utf-8?B?cjh5dWpHQjBqck1WWDQzcjlickd5WERwbzg1WGMzb05VZUZSZGZVY2ZmZDFR?=
 =?utf-8?B?RFJncGRKTW01cHJGTXprQWVhQzQ0ZVJHV01qZ3FtUHZjK2tNRFRKZUUva3py?=
 =?utf-8?B?Z24zRWZVMmVNY3hIU3BkZ2RPRXI5bFFYbEk5aVg4cExjcW9nUkxmQ2pwcFBD?=
 =?utf-8?B?R1pYa3p0RHlLWE5UeVZuakNTb1JUbFIwLzhWcHFTQUgzNmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUd6ODdERFM1a2JYNU0yNS9ER1l0YXZpVEg4N2QzNHovdXhvR2JjOS9CSDhj?=
 =?utf-8?B?MUdlL3FGN0lSL0tLNU5NdDdabXpDU3hRRnVwNVlveHNkS1BNVnRESUs3dzRR?=
 =?utf-8?B?MVhvYWsxb0NxL0RHZHJQZmdBYXdWSjBTQmVqL0JoUG1FTVQybE9lL3UrczBy?=
 =?utf-8?B?N3c2QzNkdU5HYWNMNnZLYUl2Q2RkZDFIYjFWMGpzd01hY1dVTHFRSTFFMmpR?=
 =?utf-8?B?VGtid3BwRTRyUGZ4cGZPSGhOOFh4UHYraE1Ic2NJckU2RzBqVWduenJZUkRX?=
 =?utf-8?B?WUh2ODBmbUxxeE44ZGpnZFR2Sm1tRUw5T01QZVNscS9rM2N1MnlwclZ5ai95?=
 =?utf-8?B?R1Nsa3pkcWt0QndTOW9CTzcwNW9WNm9tUXU3VzZ2R0xyUS9TeFNpcjZMblRX?=
 =?utf-8?B?UmtjRVFEblBYb2tZc3UyWUR5RkhYUHUvVW12UDVVUThNWkN6UHFqY3gvVTUy?=
 =?utf-8?B?ZDQrRU45QzFvTkN3eGJHbk5uL0lBY3RwMHhsSzJyS2JKMHpEc0N1Nnd3YlJV?=
 =?utf-8?B?RXA2RHVrVlkydUFMODkrMUxSVGxGSFFZUHExZFZISFNBRE5vMG82RGJ6ZFdL?=
 =?utf-8?B?V0kyekZSSkM5NUZTMGhnZUZGWnZZOUlvaEVjZUpZNnhaTENCTmtWRUVtTmdt?=
 =?utf-8?B?NjdlOUFnbkhVQ2NtUWg5VUd4YVlqYVpWbVlMQVdrUnVrUEtxaG5RczUrZUhB?=
 =?utf-8?B?Vzl5ZWpRQU51ZnRNRVV5eW5NZEdCU0srMDJnMTZyK045ZVdHRVgyOUMxYTRN?=
 =?utf-8?B?bmdkSlV2SXdkeUx5T3k5eXA0Tm4yUjRMK3c5ZnU3WllEUDZKMHFpL0w5MUpt?=
 =?utf-8?B?RmNBTnk3eDlpSThybHlZY0JNbHdvNFNGZnQ2SWEybi9KZHVCSnVLYnlSRElW?=
 =?utf-8?B?dzBLbUEyQ2hiK0hKeFZ6ejZqRVU1WFNEVmNKWGgvVGNsbEpmbUZtNjJGVFhw?=
 =?utf-8?B?ZGhOK2ExMkQxUENjU0xXWUhlaXdGN3NCTFJDei95QmcvUXpZUG5KY0c5eW9q?=
 =?utf-8?B?b1NpWDZab0QrR1BaWkxkTWVFSTA2QjV6eGNZdlMzU29LS3p5SXF2emJTVnUz?=
 =?utf-8?B?UWxwQWJxVUlqSGVKVThoTzVPblBrRGltQ0x0bkl0a0dCY09rYkw1Slg1TzFC?=
 =?utf-8?B?RnZDUHVldWhoWFdZaGJseEowM2N6SHZvbVo3RUNuZ1h3Mkd5amZOYklLMy9k?=
 =?utf-8?B?SFhSM29GSVVnSTBuWnk0bEJHZjRva1JiVkhVWVRkeE1vNWJUUi9sZ1psUDl2?=
 =?utf-8?B?V0NYczdUYkVqV09GNEQ0eDhWQ1o5UU52VXF1d2VjSmZOMWU4WjhGRGp2TWhv?=
 =?utf-8?B?bXhHbDBkVERIdVkrR3RCQW5abDJESFJuZUlnYk8rL0ZhRlJjaEpKN050WEZ4?=
 =?utf-8?B?VG11anFRbTZZZTVHOEVBOFZMcVdvZHJndmFydEp5Y1doQUlXRWNIclBIQk54?=
 =?utf-8?B?NGwrN25DZDg2NXk5NWdMSWtPVE9RRTllQXJmNzdBRXhPQ2doRW8xL05PYUQx?=
 =?utf-8?B?VEcvd1BNOWJtcFZabHZMSUF0by9DSGpoZGVBazBsZnFvazNLbmN2SlJUSENt?=
 =?utf-8?B?SVREbkR6aWp2RnFJVUZMZC9jZUJvMGlkdDZPWnZrTC9mWU1RSC82eUhyaXNK?=
 =?utf-8?B?T25EQkgxbmtWWlRjQ1h5SzhPNUVIczlneG9nNFM1dlNhYUZEYVZtMm5ySjJL?=
 =?utf-8?B?NVZGaGdrOFFlNWw2U0M4VlZYSTJvQzY0d1lMYmxoOE1nc0lKZGRQc08wUDNm?=
 =?utf-8?B?emFYRjlPZkVPZ1NUQXBQMEJOSTZUWGRybFo3Y3Y1ZWliT0lUa2RLeit0bEJy?=
 =?utf-8?B?bXUveXNBOE9lV2czSlgrL2IzS3BzRHVDczlCYk9XSXVUaXVaRXhlZ1RUZGRX?=
 =?utf-8?B?T0dRUUhWNWU2dGNQWjlSOWhOZkdZOWtlRnZYb1M4OXhOeFVXMTBGMUhqVDFU?=
 =?utf-8?B?bEZ1OUdMTUx2MUNIVU9LN1FzUTZZY0N2Uy9BczBWdnlWdVhPWWhqdmhrZGsv?=
 =?utf-8?B?cXVWbDNXNlVFdmR6U3ZOeUswbTZWUEdYTmlSeFN4WFNFaUJCc3lRNE8vRHdk?=
 =?utf-8?B?ZnM4aUhURFJURUxDWnlaMFJvN1RoT0xMdUNjc25rQnhhbE5IaTVTMlRsY1Nn?=
 =?utf-8?B?Tno4NytOZ0w0MUxXQ0lhRnd2OGlGeEVlaWlPeElsaExWTTFPVlVpbFpJRXRK?=
 =?utf-8?B?ZzRuWHZIRW1SUTA1QkJGRk9TRERWdlVBZnhGY0VSUllTdEVNOE9BNWJRVUVY?=
 =?utf-8?B?Tnk5bjhvMDJESERJQ2dzS3gzU3RlQmtYNjRjWkhGR3NMSlFHZWlBYnY4aUQ2?=
 =?utf-8?B?eGtCNmUvd0d4Q2daSkJCZ0ZUY21TYWlOR1lFK09keGRudWdJeTkvTTdMV0xq?=
 =?utf-8?Q?BX/Fvu8CcS9Azx8I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b53c45b-84e3-4111-613a-08de52098caf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:36:50.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOkGezWgHNfvKxYavjat/D9vNd1KYrcMX4U32owr3AAeSYH9rgKk7HQzEkPYO+rgGq3da4LaoMf1u85gc+H7gLIuCOpsKxNrpVar5UInDrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8716

On 2026-01-12 10:05, Steven Rostedt wrote:
> On Sun, 11 Jan 2026 13:04:59 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> As a patch author, I find this feedback really useful. Is there
>> an easy way to get this feedback privately before sending out my
>> patches ?
> 
> Hehe, we all want to look good don't we ;-)
> 
> For me. I let people see the good, the bad, and the ugly (probably more than I should!)

I really don't mind having healthy discussions publicly, but I try
to minimize the amount of disruption my work brings on others.

That being said, I think this AI review can lead to interesting
discussions where others can pitch in, so having it in the open
is worthwhile.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
