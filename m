Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020092.outbound.protection.outlook.com [52.101.189.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850F1D47A2;
	Thu, 27 Mar 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743107743; cv=fail; b=Z54x7oKOAvSmBI6gkdQ8WKPYN7u21T1oCHDiv2dW59lNu8EFOrsTzsdsp+zza3cP0hG8qIUSUk1PtT9FirPbRVmbjtia4UVZZLcoWPc5g/4joSHCBNfdJONOnLFOzPF0sZfYTU4DOWD1t9qCrQuC2aijOs0pMtUa/tUo2Z5JFBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743107743; c=relaxed/simple;
	bh=knBAk65KhZdRumpXMg9RA5RmGqdibwMaCwlKFP/gngU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rynmj/8G3M18NGQ9wawi0f2ex64ZHUDe3fav1tk7shfsZOGq3rkJcSze4H9xgyjPCx17YgD65Ol5FOFPtfMmVWaPzbLbD/lCQ0LcBYsXRJkoQWiAq47W0mopOk4LVOhEdZz+r9Qlc0h2FlVzIkDWBdNQr9MU9L1j+gyVvLH8p9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bB9yDzmk; arc=fail smtp.client-ip=52.101.189.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bB9yDzmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzHyspJXw+ENkVWd6/WJT1ClLlvydWU738hkE0w6Lkb3BDAHp3pzoDMRWg/++9Ro0Seklc/LYP2nBWRcEs9J12G6RkJov2BiJTt2d61TNHWXvGhxVZuQKIT+h874YRgmMlFZcXZnI/YPiPbRFfGoRZPNaxTxjKQ1wgkUT/XPaJCYOHkqOei+FFoMWKe6rOVo8Ww6LFPsxkXMf+1viNRi8xEfoX0u6yN0x50UcJn3JDwjXDcjwLqUwaqy9EqmsU0qs712G8MWAtK1Kv7uw7LQ7Ki0gxAGXJ8oNjSQoU8RrsbvkR72gfZJ3qBEd58THQhVv4GktsROQEwyAYIEdtXRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noag+/htVwVeH7LGHvLxtromhnKMAW+BaM4ncr7Q1fE=;
 b=itmXdWR3asHvVGORR37G6e7WyzF5HwgpPbgO7rzul05eHrQwo1VNqj+w2X2uEOcYkvVdNbu8GN3gKdYaBPf9O48mZ0jV2FQpxR1vcpX70KRhhjVh8NNRodmpNsuZe7l31HbKBhWyPgNNSfduc9VxCRiU3JPYx1n2wUbr5mp27r3xBUxIszScB1zr1LRTlI1HTCxT9jXA4H4/FWHyGCgoAeWk2EMfBFt0C11gUNtXhT5LyLdwm3VvZenfq3P8B4ldOy/WX0NOMpQmmiOPWVH0WpiZci6NBlOhoYkWylSkSvs9t7EDItAO6ADqJSl93aEK2Qqf2FW0LAeGLzyd7L06Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noag+/htVwVeH7LGHvLxtromhnKMAW+BaM4ncr7Q1fE=;
 b=bB9yDzmk6ZmqdBDPLIdvlYUKtZP6ltalyUDUBB9qGeI/yd77bBXSk8Og1vcAyvsfEkNykd2vIkw9oau1+ciXKaFYero8WnvUKHpuzjORJQAGu71nO4Zp51u1xAaccAkq/RZAr18QAw+oHYuSczI4ovUZk6TYpHDaXIK/y8tdSBxnVhOXOd+uLyPgYnC0+JFDZBdYKWt3GDZV9LdZwkr8//eGkr2zv+Yuyf2/kZZv5A2bjwNINzYh1rgwNA7vA0/nNpBYHe+B++kFr9GZ6fxeaZGoeXKPxtYSDpIvLtCAeOGBshFyW/p2aNe6D9KaOzS2a3UbXI0Jp+mRlL6bRDzFdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:69::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.45; Thu, 27 Mar
 2025 20:35:38 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.044; Thu, 27 Mar 2025
 20:35:38 +0000
Message-ID: <a89cb4d9-088e-4ed6-afde-f1b097de8db9@efficios.com>
Date: Thu, 27 Mar 2025 16:35:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: use per-numa-node atomics instead of percpu_counters
To: Mateusz Guzik <mjguzik@gmail.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 Jani Nikula <jani.nikula@intel.com>, Sweet Tea Dorminy
 <sweettea@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Greg Thelen <gthelen@google.com>
References: <20250325221550.396212-1-sweettea-kernel@dorminy.me>
 <evqxyt5dkkervut7q4ea4dnykcz75lxx2wvqyg2lq7m3ptam3c@53ao37tlhytk>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <evqxyt5dkkervut7q4ea4dnykcz75lxx2wvqyg2lq7m3ptam3c@53ao37tlhytk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 68979828-ae27-4168-e6a2-08dd6d6eef06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?di95QWdpb05rR2VEbTBaaVVtRVZ0Qmp3RGt0TGM3cTdtVnRJN3diZSt3R0Ra?=
 =?utf-8?B?VmtYWkRzSmZFa3NscnFoVUxUbHJTVUxFVUtTUmppajFtK1ZlNURxYnFtRmZH?=
 =?utf-8?B?OEo3VTcvczQwMkxIT20xVUd2RGRSemJxWDVPd3lYbktxcVNERkhvMHVZakxP?=
 =?utf-8?B?aFVlcVBhbml0MEMzVzllaXZsNkhUQkxMUmFKSDNoQUJJaW56dm1jVEE4ZXRZ?=
 =?utf-8?B?NmdzWWJsV3hmRzlGQkVQRnIwOWZlOTQ5UER5Y01YRGFvTHIrdXRnOHVVNW9r?=
 =?utf-8?B?S0F1UlE5QVZUUlNJc3BJM2lEWmFRYTU3WDI0aDQ4NlBVeEVZVmxuemNPYVcv?=
 =?utf-8?B?VWtnMWVWdGVzdDl1bmZvalhKaWZCenBCbk56amlkRmtzaFd1VXZBR1JsSFp1?=
 =?utf-8?B?Ync5WmRHS1oxaFpvanE1YkFTQ2lsSjI2ME50cTBpOWI2Z21VU3ZMeGhKaG1G?=
 =?utf-8?B?TjJjcmVTbG9lYmtDaEpjRTYyanU5SEFnM0RRa3Q3WDBSem9ZcU55ZDNpVjd4?=
 =?utf-8?B?Y3MrSjM4alFlMzgrVlZHZkl2ckpnMFJ6TWdUL2x5cHNOalppNnBncGs0ZXJp?=
 =?utf-8?B?eG5kNGIzcHhqSFdOOCs1Z0tHNWREV3RPTmE4T1g1MllEWW5ZdkFYbk5UUFU1?=
 =?utf-8?B?a21uWU9FK2dUSkQrR28rZ2FLcHFnbnhmNkJ5Vm9nM1N6b0h5S1lJVXNCNElX?=
 =?utf-8?B?Um5BTzB5MXdYZ2Nza0tYUnNJeWhDTkVQQWNnQzY2NE9QemZDcFM0dEtXWmlh?=
 =?utf-8?B?K1RzMUxvTU1RRGxyakp1bzBMMW9nTmRRdkZrUlY2K3JnRDluOEw0aGhWU0tP?=
 =?utf-8?B?a0FXOHBTeDRCT1BOa3l6NU50YmU0dkxpSE01R1ROdG9RSWZTZ0RjOXhvUEdO?=
 =?utf-8?B?Q1pPSkxIUWJzWU1nelhLSlM2VFhEOTJkNlhob3pIVTI1bEhSbkhyOWxMVUZX?=
 =?utf-8?B?K0Z4MitHVnVmdU9XdFlSY0dtZFIrNm00YzdaWlk5ZHVBTzJHZzJyUmIzT3pZ?=
 =?utf-8?B?ODJyZ2phSk1GTnd1a21LelhiZ2hwcEZ1cFpzTWxNUGNyY290M1oxVVdZYWNF?=
 =?utf-8?B?eEx6cy9MTUJJcnN1b0xkbUJNVFROc3hZR3FpUUlvbW5xOGdKZno3Z2d1SVBD?=
 =?utf-8?B?Y09LRnJ4MUVVSGlyODQrcUl2b2UwKzFpRDVjZkFGQTMvVHVnaUxQNGROUUo0?=
 =?utf-8?B?dWFFWVNMOEZzd1Q0WFp0ZE9tdmtpYzFXNTBITG1HaXNVenVOT1VHTmYrN2Rz?=
 =?utf-8?B?UTQzYTFSWmkycUJQRkJ5VUNhR2tueHpJb1ZCR1BrTnZ4dHVML2hscFltcEVo?=
 =?utf-8?B?VWdhSFYvUmErQi9qWk9IQkl3eFl1ZTVJWHFRYU9KeFJKQ09ydklESHVHQWND?=
 =?utf-8?B?RGFOTHhEWnJqTmYyTitnc0JWM05ET3R5S05tQ3NkTUV4NnZtbDNHeW81U1hx?=
 =?utf-8?B?OGpScC8xOE1HM2w0YUx0b3NUTUE0WVl3WEV5M3FZbzVMWCs4TWpSL1EwS1hM?=
 =?utf-8?B?OHVQUUpYazJtUGUvMWxMZWpFdXRBamZpb1M2NVVBU1dNRDV3MGUzcmtvLzVu?=
 =?utf-8?B?cVV3YlpQOGZRL0d2VGJwT2UyZXcyZVUyUUZaZzZUUXoxZ1dtc00yZ3Vpbmlr?=
 =?utf-8?B?MGlkZDlBaW4yNDl5YStRY0QyTWNIcTk3MXIzdjRGYS9hODNYdzRScTdUZjJX?=
 =?utf-8?B?RjlDd0ZhNk5hcnFDZE1QaUZNRlpqM09EUUhKVmJhL2dCVzFmbjljdFNIZ1dz?=
 =?utf-8?Q?3p5gj9VEkfrqNFurGlhmS3mqcclKBPvUErFCPCN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmlxMGFaU2dHcWFZMmhEUzJ2QUNqbWZYNnBTSThNVTRPWlZibERTWGNrL3Ev?=
 =?utf-8?B?NkkvT0JlczYwOExwaUpQbTIzbmlVTUNwMXhtTmp6cCt0RlZWRlU3MjQ0R1E2?=
 =?utf-8?B?SlJidGwvM29FZWtCRWNIbW5nT2R1bytDZnRVbU1BeHo0YTN1bDIxL3BEbXBl?=
 =?utf-8?B?V2hQRE9vMTJYdjFldHlqVkJMQjhLWW9DVWlSVFZmTlF0VkR1T2ZsaTFtTGN1?=
 =?utf-8?B?aFNIZXFSNERnMWViSFkzT1JpeHk3bEhFVUlEMlk4NW1VR055RERtUGxSUzU5?=
 =?utf-8?B?eFZzU0R3bVN1aVgrenZ4d0k3WVFKNWorYVU1ejZzdmQ3RDNzdzFoS25yelp4?=
 =?utf-8?B?Y0lvRVhLcjBQNkVVb2ZnM1FDZnNsOGlEak0yeVIxTHRCcmFJeWJ1THQwNmxn?=
 =?utf-8?B?bWRpeVdBZldyR1A0YWtLT1RlRERkNzVlR0dGbzJucE91WTl6eDdMaUI4UW5I?=
 =?utf-8?B?bVdpT1V4V0RhZmV6UkhPRlVuc25nK0k3bld4L1FZcUUyRlMzR3dkemZ1eGg1?=
 =?utf-8?B?Y2dQUGs5TkZqT28zcTUvalU5TWkvNTcxUkw0SFBGZEZhdXdlZyt3SGpxUHhB?=
 =?utf-8?B?Y1V0V1J0RWQ1OUhSaFZyck5TaE56UXBoYkZBWlVmYklGUjZmS3dpVVhHN0I3?=
 =?utf-8?B?b3FMRlpTeDg2UWNyQ2h5bXpMT1NETndTU0syd0Z3QjZ3NUw5Y0F5T3FCY2VZ?=
 =?utf-8?B?Rm81eTc3NHdScno4VzRoM2lsUzBmdC9BMFh4cUE4MUVQeTFaOFY3b0RYZll6?=
 =?utf-8?B?UklTeTgzV1E0aXlpUklPSmhNSGFNUjhjNXA2cDU3UFNLUUZ2UlpYMEwxTGlr?=
 =?utf-8?B?WDFkRGdjT0lxcWpaR0E2eU9xZWFZdmZaNFZQcGpvWTRjakRTamdpKzcvbzl6?=
 =?utf-8?B?VEhyb0VGbG8xV3RZR09nckorK2RLQ2REMkNqTWhvNzFteVlMMUlIZ1JacHpt?=
 =?utf-8?B?dFY0NCtteGdFOGEvaDdKaDZ6RVhybUF0bjBXR2k4SWhWWmhaMGFVZm5ieHB6?=
 =?utf-8?B?ZjBEMFcwaHlINndBdGFuSDlRVHV0c1lFVFlkZTZPNEdqMjgrV0pkL1pETTlO?=
 =?utf-8?B?QXhNZlk4U3BBQnhDdVk2dFQ4REtBNjVjRERpdG9KWnk1SEMzbEQvMkppMlRn?=
 =?utf-8?B?Njdjb1dWYU9ZVDhycDBPam1KV01wbHRLcittUlZ3bWFpeHRBMHlaZkJUUUdM?=
 =?utf-8?B?bjVpWXY0NTl0VGhsb09UQ3JlV2UvbEh6TmU0dVhoK3JBM3E2YUppZTVtSm5m?=
 =?utf-8?B?UWxEaWNReG5pVGNHS0pWZ21PVERCM0VxTUltWURFTnFydWJabUcxREdiWi9H?=
 =?utf-8?B?eWVSQ3FOTlE4NVk0b3ZyS3VydDBENzltblBGeTJOVTlTSUNLRVZFejRTSzRW?=
 =?utf-8?B?T2FaSnYyUzJkVU1BbEJ5dW5JVDlhckVNaDdPRFNGa29UYU9UcStESjRzbldF?=
 =?utf-8?B?aDlRYk1wRVZPMXlZYUUwM3VDdThpM0JneU9jN202TGRvZTYrNjlWSHNXV3U0?=
 =?utf-8?B?ZmdaTTBsb1hhcWhTMlpHaEtIY2RqZElldSs4VE9XZFRGUFVZRXhteU1Va0NM?=
 =?utf-8?B?Y3JpVHhBbUFkaDlEUElwam1udExDc0JGOGJkaHpxNHBoYXlWZmgrQkY3RG1u?=
 =?utf-8?B?OVlURE5Kei95TUhmYzE1YkZiQlBpdXQ3REk3R2RqenQ4WFh5c0hPLzdEdldI?=
 =?utf-8?B?UEtuNEJJby9Cc2xyaThUcFJCamMvQU0wZnlobE9xWlVzcmVBeDZwb000eTc3?=
 =?utf-8?B?MUsxTUpocDg1WmZIekVydmc3djFZS0MzY21OUGR0T3poMTUvY2lvMzErQVVG?=
 =?utf-8?B?a2FabStreVVmR0hKeWhHS3I0VS9pUzg2L3lrdVduNExKalZRRVM1dk9JK2Ru?=
 =?utf-8?B?TmhhNGY1UnAwQVFRMFZTK2hiR2RuTXdmRDNlaXNoY0w5cnZmeGJzbStTcWNt?=
 =?utf-8?B?VFhaNENQa1VXRTJZMWdqY3hqckk4eFBFSzFvaTRlbWRGQ3l2MGJ0OEpkR1FS?=
 =?utf-8?B?WnJlU3VGQUNlWmZNWXY0d1JZcGtoWVNNQVQxa3JpQ2RmSnIwY3FGUWhsTWFs?=
 =?utf-8?B?ck9UdnJ3eW5YUkNsSnRMRnFOVlk0amk4Q1p6YjdJOS8zTmV6VU8veUQ5dklo?=
 =?utf-8?B?bTV0WGJKZE1Sa3M3aTBpQ0Q5amhuUUcrQTJHL2hqVWhLLzZMVTlIWGRENVJp?=
 =?utf-8?Q?Il6Dqwiu4YIfHK+BfG0i1CA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68979828-ae27-4168-e6a2-08dd6d6eef06
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 20:35:38.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+JEzmTVpDWAKXLcc/aGgB/Dw4e/KFZpG3MgcSGI4qWczZDc7vZjO1f6VkeYwj6Z2kpd3P7/ZBH0EkZPf0i/nAqBi+RUZ73Ibd7usb0dPt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6116

On 2025-03-26 19:36, Mateusz Guzik wrote:
[...]
> 
> Hell, it may be your patch as is can be easily repurposed to
> decentralize the main percpu counter? I mean perhaps there is no need
> for any fancy hierarchical structure.

Here is an initial attempt at a design document for the hierarchical
percpu counters. Feedback welcome!

Split Counters With Binary Tree Approximation Propagation
=========================================================

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
March 27, 2025

* Propagation diagram when reaching batch size thresholds (± batch size):

Example diagram for 8 CPUs:

log2(8) = 3 levels

At each level, each pair propagates its values to the next level when
reaching the batch size thresholds.

Counters at levels 0, 1, 2 can be kept on a single byte (±128 range).
Counter at level 3 can be kept on a 32/64-bit counter.

Level 0:  0    1    2    3    4    5    6    7
           |   /     |   /     |   /     |   /
           |  /      |  /      |  /      |  /
           | /       | /       | /       | /
Level 1:  0         1         2         3
           |       /           |       /
           |    /              |    /
           | /                 | /
Level 2:  0                   1
           |               /
           |         /
           |   /
Level 3:  0


* Inaccuracy:

BATCH(level N): Level N batch size.

Example for BATCH(level 0) = 4

BATCH(level 0) =  4
BATCH(level 1) =  8
BATCH(level 2) = 16
BATCH(level N) = BATCH(level 0) * 2^N

           per-counter     global
           inaccuracy      inaccuracy
Level 0:    ±  3          ± 24  (8 * 3)
Level 1:    ±  7          ± 28  (4 * 7)
Level 2:    ± 15          ± 30  (2 * 15)
Total:      ------        ± 82  (log2(nr_cpus) * BATCH(level 0) * nr_cpus - Sum[0 .. log2(nr_cpus) - 1](nr_cpus / 2^n)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
