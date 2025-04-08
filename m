Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020118.outbound.protection.outlook.com [52.101.189.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF9231C9F;
	Tue,  8 Apr 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140592; cv=fail; b=SPKiD855ByepBXz6/DZZa8S4L9v8gQFosu8nsFbNqqjUrZe0Kict6gCJjVO07yHjJOE9GoHGSxjeQbM2dSDiipsqmjGtMuBr/lMZ3cjqKZqonUyB3ouq/lz7+L+Vh+uc1GFjO8BkxEBq0SA3nLxNIn/Sjqt1W+hOosgX1hFwRmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140592; c=relaxed/simple;
	bh=P5X3zvFNCaG05rc45/uVw5DKxRnFG0QQ0LCeuU4oZx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aXsPJuCdEYwnkkw+xbKhDwZdrdbA740vl0ct9SHaEL+Muvs2PMKRLKsoo/4pzTxhgCCxCeT47eM8c8DwxUps+a8+lcSvj5/aWfU7Fqr8RzH3BYDbN3fjkgy4VBoQKTS+SFmceInC/8NFU65uZ/MsAIeLjmzOhg6E0DVwATj16yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WrgE/I3k; arc=fail smtp.client-ip=52.101.189.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WrgE/I3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8sTq7RZhtbYgP7siVBfbBFdTMUf4TiRyxe6ycv5U7lEBrhCgi+kE49lAFo12//ia+dV0pfHCwJAhOPXZmyXW/17I9GX1mh/vc+utOkFB2ufivD37tVUZ5BZMieMaq8zxrU5UPHEme0Eln3c9Zq2RtDyxpE2JGB4Gdd8+psoZ0T1edQZ1ZcQwCxr0FsOioeHM713Ehezcz0zHEAOsOl1ugvI9IDXF+UXxh1xrlz7Bb6NP6hj8FJTL0HKFogIHYwNb0zPMbS6qVk9/2ii00GbZEr+5kINOcds2AQHOpIHa0R66gWrw+2Av4KL0LBi4dctg8HDXxiNnwXymZ5uSkoUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6lLtXf/6Gm4UVC6i7dGN1IVcnP+6GsVbmKalYDJ1Hs=;
 b=w77m0Ve2ildlWAaoWOrWZllxpfd9vK6PJgsj/4/rXiCGZHK1lBcUIxLdYkRZOKdHXylH3qyc0inkg/tvs9nXZr4LjFj2b/lyGSRg9vsj8X6awH6VqPJE4Imm+lW9FuE03Dzo8DYeqfhc6CSeS14+SItnlTIo89azIgq9eiJ5St9aR6hCPvhcALnAu8xohB2Fo5ZkrtkuJGkxYujt5R9vitB8eaQ7s0owRDDxtIp1fGpx+L5/o0SIhLjckf14w1A0hK3/kWcNk/d+4oKEo23M0Su86cSIsh5iCLGkdeJR1qVTQvoz1iiGxLjFd9TlItJlTU9RaOuXs+brcBgewyj15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6lLtXf/6Gm4UVC6i7dGN1IVcnP+6GsVbmKalYDJ1Hs=;
 b=WrgE/I3krvT1pwYTSKZCEkjjQHNgKWHbQ8Yrv6BkqkV7Hyte69uDo5U23dl78ZVDkxw0q23Bl+jQ2kksa+tuQDEXSkVSkW5dB9vJWETZVWjTV9vPOh1IwTk3svIY6W6aXdoqlbILk1mHigg4GIj1Vs5UlRAAFqRdxmsWx9crbz+n3BRt7rSFWUyUyKjgseWA93SWbW2KOP2IpaXMBOyS+dN09sy911HjtK1xkEP24DCyN61Uch38WVT+DIYEbM8+vpvfZaxc/RCAzl1+QtiAlsCFCLi2EpdPF8ObWZZtrMVqDqP6D6i23EvbEQEh/BIDAqxx3fLKIYeefiE17mHJbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6583.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 19:29:43 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 19:29:42 +0000
Message-ID: <f014a9bb-0653-4682-8608-7fe6e2ad5ee6@efficios.com>
Date: Tue, 8 Apr 2025 15:29:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Sweet Tea Dorminy <sweettea@google.com>, Mateusz Guzik
 <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Matthew Wilcox <willy@infradead.org>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 705a7452-1e64-45d8-1eae-08dd76d3b645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWdlNTFxc2E2R00rR3RSU0JIdERPQzRJRVVJMExzMDhIZXM4Z3gySUtiVW95?=
 =?utf-8?B?bTJDNVcvdjBNMWVmd0N0SWtEZ2JMaVhzTFdERWcvem45REEremJFL0d4Mzc5?=
 =?utf-8?B?eXA2ejFkcjV3MEJsYlFVTjBVdUFHZDQ2SElmQk1vNzM3UWRhTVpMaFVqNUJY?=
 =?utf-8?B?Y2lmM3phWXhCcUhWTVBCWnR0MzJtNDhPdEFlMHV0STVEeHM1QWZTYXNnWWJL?=
 =?utf-8?B?NUdtZjN4bVpQNURic0FZandORndYcUlrakk2V1NSMWVkQ0RYZXlZMjVYNENp?=
 =?utf-8?B?ZFZYSHYvQnh2bCtuNlN3VG9oY1R3RUd4WkVNdkZYZGxNTG92b20xRUFocWNt?=
 =?utf-8?B?SkFHY0NpNy9DTCswbnVuMG90cXlxdEZaaXFIZzJBMGxDVmFkaWtDSjhocjVQ?=
 =?utf-8?B?Vm9HUk5PcVdId1ZseHpMaWkraThjOUk1SFNrQU44VC8xb0NxUDNndC9YMG1T?=
 =?utf-8?B?dXpjeVNDSGtkL0RYMWppbzJCMnRpR3pPUkdPaysyT0NhdUdKSmJCVnJtenly?=
 =?utf-8?B?aWxhejhHUmFMSHBsdXdQYWFjbDdEMHBFUFhsTE0zQmU5SzZjc0RIejZCZVov?=
 =?utf-8?B?Z1A3NDU0NlVZaE9TNUREayt6R2N1bmtLbnh6M1pUd0xUUEV2aGdpUUlPVUxr?=
 =?utf-8?B?ejBsd0s0RlZ2WUhCMWVjb2pCeEVXcW5MWW5VZVZkV3FSSUFiSUxydGlUOVVE?=
 =?utf-8?B?TEZmOE1mTFJBS01FdDhSZHkxbkd3alZtcTIwTWtiUGJlUk03bVBOQUkva0Rt?=
 =?utf-8?B?UDFhM2ZpS2p6OFZncktLK0Q0Q1RYVnh1R0xhTWhRWGo3UFlWWDZzVHBMckUz?=
 =?utf-8?B?SVZOb2F4WXYyd2w0S2FKKzZPVnNNZDltWnlvbWVFNjZHZkxTbFRJU2RVc3Av?=
 =?utf-8?B?djlxTFhsZHp4VllBT0dnRVNFR0huMnFlL2x6aGw1NE1WUkZPNERyZmNtNHVl?=
 =?utf-8?B?ZXo1eFgyOCtPRFdqQ0Z5ZUZRaDNVWWgwbTRwZEpjYnIvZ3NMamdxemJkUFVN?=
 =?utf-8?B?REltam9KaURzeGllUThaNVlpaUhSYyszWlo1aXNmcG44TjI3ekJPSHpINHN1?=
 =?utf-8?B?Ti93dGFCOE9DMmh6UW9PZjVqdThmUzVFVFlTckNRL21Eakc3TDEveGFpbldT?=
 =?utf-8?B?QUNTKzZUdVNkRExaK3RsZ2N4aHRVeVRsckg0ZjdzSm5MQXdDaVYyUi9vdmtM?=
 =?utf-8?B?MDlIMjlyVHdRcHBtcHZZNFd2ejU5eVBSUEZETDJFb0Y1aStQVTJtUmhJbzgz?=
 =?utf-8?B?QnhqbEd5M241elZSSzNsd2dib3lQQXc4WHZxYnJNZHZsbkpwNjZzNTNmaTQz?=
 =?utf-8?B?eHVTa3pZM2Y5ZHVkUldnY21hMzdUSXdRT3Q3QkRGRFo3TTUyeGdaSkQ4d25O?=
 =?utf-8?B?c2p1VG9ocjRVM0cwTGNaZHQ5TmFHRC9ITHQyZ3MzbDcrQWVISjNVcTVHM3NG?=
 =?utf-8?B?VzdHRlplaFBmbkZOeUhMeElKalcyR2o5Mit3cTVnWGNQUjgreW9BenBLWnhv?=
 =?utf-8?B?c00rVEMvTFZzYS82bld4NTZhYmZLRkQyNW1xSFlKMXU5UDNFNGJSLytwM1dh?=
 =?utf-8?B?OWF4NkNDWGttbjZha1UyODBhbFB5eUdUeUhqSVMvV24xU1BEbG1HTFFGUVB1?=
 =?utf-8?B?MmJuRzdSV2dMMEpJU24wbDdLd09HVUU2TVduemxxWVVTbERqbDAyaEVCcWdH?=
 =?utf-8?B?MCtDVm9zM09jOTNLU0FZTzhhTC9KZC9TNDU3eVNFL1VwbHVQcEVnUEVWUldG?=
 =?utf-8?Q?GlYMEObaBXCoLv/PYTcIrV1BodT1/HKk+MPuL02?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2Rrd0hnM1FQa2VrZDFqSUk4ajFncTJ2TjF4ajN2cThuazFpS2l6aDloN0Fl?=
 =?utf-8?B?QlNhSmFqa0plUkxUS0tRYXlEb2w5TUlLTm1TMGVzNFA3c0tIYm5IS2x4bzFq?=
 =?utf-8?B?SUsrMkp3NDh1elp0b1diclo2eWlOUVhOV3dxS3dhM3MxcC9pZkprUE9YUGFp?=
 =?utf-8?B?aHEyNjFMRGMvSVMrL21KTEg1ZmVYMXgya0lxUjdoRGFSUTNhWTlVc2hJdXNU?=
 =?utf-8?B?REsxa0JDdXdHSjZvUms1ODR5OURtQU9qL0VheEdyWGI5amJDWHJSbjFlTEY4?=
 =?utf-8?B?NkJQRzdFeVdRbUFFdU5OR3E4M09JNDAzeEk0QkFaWERINC83Z0ptT1FBdDBq?=
 =?utf-8?B?RHJDQ1g0RE1RS3NRdTBYU1k5RE1rSXBHOU5QcEdHK2VhTUFTZncrNTV3NFhi?=
 =?utf-8?B?dlNmMkpiWEJMR2Y2a1ByL2g1V3JqTG93MS9LcC9IMWdKcSthSVcvVlhWUll6?=
 =?utf-8?B?NXJ6TVBFdzdHWkFSYmFObmwzNEFHc1E2bFpJd1krbmt3cHl1Mnh6U0Mwd29K?=
 =?utf-8?B?NkwrbkgwWG94TWVlRDkwQm5pMGNVUTU1YlRMZ2x2Q09MKzdGVTRwY1RTZ0dr?=
 =?utf-8?B?ZWhiYWtWSGptdjErVkpweVQ2dEZWSG5zYjNuZ3ovcTFqbkhPUUVXS2k5QUxC?=
 =?utf-8?B?eGJTelFzWnFRTEo0bWRFRUJmRzZzMnZWVWNaYlM4Ylh1Sit0NTBDMDhCY1RT?=
 =?utf-8?B?OXEyblBEb2FrZjRNZXYzOHZSTUFUOVZEUlNXeHB4cXJrcUNXYjBNN3JOdmsz?=
 =?utf-8?B?OHBNMlVsNjZSaWRhejJ0NUhDR0hLVDV3MzhMUHlxck0xN1Y0MFR0ZDd2WXNh?=
 =?utf-8?B?MkxQcVFTZHpsTGtoZHVKKzlieTgrbHhSQzVTOGtEMnZkKzJWVzMvaDk5TVVZ?=
 =?utf-8?B?WVFWZlRrTGZPVUNFTFpUYk0wRlpOOGxJQUZPZzg2SDlUeWhrRWVZcTcyaERC?=
 =?utf-8?B?RzdEcVArWWk0bnI0UnJDT0ZwdE5VTlNFTE93SE43UmcraXd0dU9rWEFHNWdI?=
 =?utf-8?B?Q3p4VmtZMXV2a3lUcVkxL25Sem9zZ04wM0hHK215TEV0azFwc21lTFRmKzVa?=
 =?utf-8?B?a1QveEI0bGlsTTNRcjJxSlVVT3dudkhXQkdoTkduSjFXKzJEUUpsd205bTFU?=
 =?utf-8?B?NXNya2F5RXNxd1ptaCtyZnZBZmprb2c2blFMMS9Hdy9XMGZySnNCczg4eEV3?=
 =?utf-8?B?dmZJdDlGVkhUeGJDcy9LVDZZNXpRVWRvcDRBQmJiYVBWT2VnbGptcGk3eWlF?=
 =?utf-8?B?eWJWbjJ6WVVPVWN5dmNOVUI3UlB0cjJPeUlEaS9MYnNCNC9qN1NKYVpqZytx?=
 =?utf-8?B?Umx2QUsxK3VDRWU3NzNScFgxTEQ0VWVma3QzWDRyenl4U0VjcFFYZDZMajZQ?=
 =?utf-8?B?TlJuVnB0RCtIRUFBRXd4TTNWaHhVZ1ovWlN0T0xVNGxtUkxGL3VSNk9hQUhK?=
 =?utf-8?B?MnhKdnk4WDZ3U0hrbkl0R1lEUk8xcmZGUENjUm15L3paOE00M0Z4amxjQWNV?=
 =?utf-8?B?bUUrcGdHaDdTMXdCV3pSUXlQMksybEJ0bW1MVlFDNHYvMUw4anJKY0QvdjI1?=
 =?utf-8?B?R29HVGFGeTBSTzNGeWtSME4xWkNyaXdXN2t5K1hEeDA4WjJLNGhMWmFIVStF?=
 =?utf-8?B?N29DRmFFOHdCOW9LcFBnT0VmVDRxQUJOMDVoc0NsSGoxYjg0c2pFNWptS256?=
 =?utf-8?B?d3JtWGZGUmxZZU9FSEdJb0NtVkw3dGNneGp3bnVHbzdXelhjdVhWUVhJVGxZ?=
 =?utf-8?B?ZWtKSVlLWXA4eWdPTG1ycFVlcllCQVo2dzM0dzMvenBUbFQwWTduSEZGY2Jx?=
 =?utf-8?B?Zjkvd0xEdXhZdXA3WkR6N1dYVUU5QnlZVVJMRVFMb0tCdU1mdXJxTVVBb202?=
 =?utf-8?B?bGpqUXVDSm9raVhhRGozU3JUVHFTbDJEZGRTTkozMjVFOXBUT0h5ZEs0eHY2?=
 =?utf-8?B?UXl6cUErYTBPU0FOOVRoN2RwWTltZ1A1TlVQSUpQdmFoT0xRdWxleTZERkdB?=
 =?utf-8?B?bXAxcm5YYWNGRDhjdFYwY3d3RFNsS3pEVVlwRXk2ekFmS0FaNElXbGhpa0Vm?=
 =?utf-8?B?endjVWVWTlp5bW1GWHNoME16NXhoVnJqVTFsS2VzL1czZzJiU1BIVFhIa2FC?=
 =?utf-8?B?dEVheWlVOGV3MHdPSGcvWnNzaDZOT09VcXdsSXozS2tNNjhpYTUxeFZZNGhn?=
 =?utf-8?Q?qRnWlk1zMcNfRuhksfGIpHE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705a7452-1e64-45d8-1eae-08dd76d3b645
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 19:29:42.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGXbw1s6u+BaYRq/IguKnrf+CH2numvX/jm3UzTJpSoMLD8xR3kVxifuvPkgtbwREK2YQnhy6YSnGoRFuu2pMBuB7/9IIJzlJxXCTeeuhYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6583

On 2025-04-08 12:37, Christoph Lameter (Ampere) wrote:
> On Tue, 8 Apr 2025, Mathieu Desnoyers wrote:
> 
>> - Minimize contention when incrementing and decrementing counters,
>> - Provide fast access to a sum approximation,
> 
> In general I like this as a abstraction of the Zoned VM counters in
> vmstat.c that will make the scalable counters there useful elsewhere.

I'm glad you like it! :)

> 
>> It aims at fixing the per-mm RSS tracking which has become too
>> inaccurate for OOM killer purposes on large many-core systems [1].
> 
> There are numerous cases where these issues occur. I know of a few I could
> use something like this.

I'm looking forward to see it used.

> 
>> The hierarchical per-CPU counters propagate a sum approximation through
>> a binary tree. When reaching the batch size, the carry is propagated
>> through a binary tree which consists of log2(nr_cpu_ids) levels. The
>> batch size for each level is twice the batch size of the prior level.
> 
> A binary tree? Could we do this N-way? Otherwise the tree will be 8 levels
> on a 512 cpu machine. Given the inflation of the number of cpus this
> scheme better work up to 8K cpus.

That's a good point. We should probably tune the tree n-arity to limit
the tree depth to about 5. Here is a table I've done showing a possible
n-arity choice for each power of 2 nr_cpu_ids:

nr_cpu_ids that can be represented at depth N for tree n-arity
2, 4, 8, and 16:

    N      2^N        4^N             8^N                 16^N
--------------------------------------------------------------
    0        1          1               1                    1
    1        2          4               8                   16
    2        4         16              64                  256
    3        8         64             512                 4096
    4       16        256            4096               *65536*
    5       32       1024          *32768*             1048576
    6       64       4096          262144             16777216
    7      128     *16384*        2097152            268435456
    8      256      65536        16777216           4294967296
    9      512     262144       134217728          68719476736
   10     1024    1048576      1073741824        1099511627776
   11     2048    4194304      8589934592       17592186044416
   12     4096   16777216     68719476736      281474976710656
   13    *8192*  67108864    549755813888     4503599627370496
   14    16384  268435456   4398046511104    72057594037927936
   15    32768 1073741824  35184372088832  1152921504606846976
   16    65536 4294967296 281474976710656 18446744073709551616

nr_levels is the number of tree levels for carry propagation
(excludes the final accumulation counter).

nr_cpu_ids   n-arity          nr_levels
       2         2                 1
       4         2                 2
       8         2                 3
      16         4                 3
      32         4                 3
      64         4                 3
     128         8                 3
     256         8                 3
     512         8                 3
    1024         8                 4
    2048         8                 4
    4096         8                 4
    8192        16                 4
   16384        16                 4
   32768        16                 4
   65536        16                 4
  131072        16                 5
  262144        16                 5
  524288        16                 5
1048576        16                 5

> 
>> +int percpu_counter_tree_precise_sum(struct percpu_counter_tree *counter);
>> +int percpu_counter_tree_precise_compare(struct percpu_counter_tree *a, struct percpu_counter_tree *b);
>> +int percpu_counter_tree_precise_compare_value(struct percpu_counter_tree *counter, int v);
> 
> Precise? Concurrent counter updates can occur while determining the global
> value. People may get confused.

If counters are incremented or decremented concurrently, of course a "sum"
reader will either observe the value before or after the increment.
This is inherent to reading a counter concurrently with its updates.
However, the same can be said of reading a global counter concurrently
with its updates.

If you introduce an external synchronization mechanism that makes the
updaters quiescent (e.g. RCU) before reading the counter value, then
you have a sum which is guaranteed to include all prior increments/decrements.

So using the term "precise" does not appear misleading to me from that
perspective.

> Also maybe there would be a need for a function to collape the values into
> the global if f.e. a cpu goes off line or in order to switch off OS
> activities on a cpu.

Currently percpu_counter_tree_precise_sum_unbiased() iterates on each
possible cpu, which does not require cpu hotplug integration.

Indeed, as an improvement, we could integrate with cpu hotplug notifiers
and move the offlining CPU counters to a global accumulator, but this would
require the precise sum to synchronize against concurrent CPU hotplug. That
would allow the precise sum iteration to only consider online cpus.

Note that the hierarchical counter tree algorithms for both the
increment/decrement and for approximate/precise sums are conveniently
lock-free at the moment.

We'd have to consider whether it's preferable to keep lock-freedom or
introduce locking for the precise sum to iterate on fewer CPUs.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
