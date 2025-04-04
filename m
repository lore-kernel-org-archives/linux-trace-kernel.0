Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020113.outbound.protection.outlook.com [52.101.191.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC97E0E4;
	Fri,  4 Apr 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782533; cv=fail; b=jjxcQ+gEJmP8K+yvF2Ege9T8S7iKH2WovmscG/x16Yr7OkDhSNewH+TS7dthIwhVVfq6miWHWP0egDtzkvTnxALHN6pr3NMjaK3MlbRN8wcXwQPX5eEnlgLhe3n5Nidakbob9s2scmJOxATIIIpaYTBmGtN6raniM6fsbPLcRqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782533; c=relaxed/simple;
	bh=wwtJOatsAVq06+SoiZSMfKtddg2CLFCs5+s3eaPr0G0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBiTavp2K4mgsXOk6nTeaR8Gls8H+cfRfu0iw+H3XuJjBJNlSmXrcUY565/5SmcEoYtPH69tjhDK9mAEVJVCvScIftaxDh6Q63+pdOCVUVDC2TwpQW3ccF0xW3oJzVhcMBAhLRcjF2sTkVqY/otFlHlRaiimVzNLdJPZsYBtOXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=V++S+sSp; arc=fail smtp.client-ip=52.101.191.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="V++S+sSp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3G6eoI7zOi6HKXFbkpkpS3xtXHW+AEYHD4Xzri2Ku71Yk/pSSvI00y348LvbyuLrib85UGcrHBBTefLzqV+2sDZrvqj8cT5TGQif3lGBSSfDsLcR+YfyHEQHjOut4dtfMjF/DsgSyv1mcqKIgZTqEKe/gNik1CSq/DumvN+bAwUWal/OerQcBwMyq4F0awU3hSLfxsftz+ZFjvi7JmpKVJa1lHKfermjM5spASm36X6VQTnCKbqQ3H3lMHRVbnq2nVTjdioV6vpZUOQnJycoy47J1wGNWdufRrsoPnFiI4p8jSjpTloZtgxjRVODJsngI8mh/jgymHEDxU+82souA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faWwF0wKg/ZAftRayruqYrIqkatTCOYF1U7XzwJZIaM=;
 b=eLtkl+cSIm9JaLT8Wl9R6L7TcK9JU70tR5GQ0avT2klig+zzhmawXm3O+hlLHBWVy/JTShH2wxrRHHK1g0bIHr2XPPc5xU9BaSX2Qptzy7z0LNQaYmJ+Y1O0lol8tc9VDjwRBagHqOwBeBGTa1PwYfFNWClq6MyzTyAaXFNFeuHRT58MyH2d+nXkC4EWVPIJuNH2n7Mu6kUUFGQqgANUAC125uQDI/pbptO1OfPR1pvJVtRKt8oFngtSOaZdv8fNavKR0s/6ShhhChciHNetwYJM9yTZTKYfP/yo2VzLI6UzoNSGmPC9/THKQMQSSMaIK35UJFJ1B/ehsPffk7+IeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faWwF0wKg/ZAftRayruqYrIqkatTCOYF1U7XzwJZIaM=;
 b=V++S+sSpGByIYAeJALTmxTTxfLxoVtgUoJLlAu1p3TKogeat5MKSK3kPsORV/H3H6PTE9SfhTciE8CXNt/ubiZgdNqKXKQGiCSyR5C/Lu0MTuA+7j7ROPLtuhzaVmnkM8jmL4FegQLwBlHpzezhKpJ7xL5nXl7hG+t/Xewy1JNGAZW7KSZxeu7XnC7FCH60vl1GrrnDOTbmbo6sB01Ssbf9yIXP+CGCAuEn39RB8Ljl6PKHVi5J2doNOiDYJYK9J1pDoJ8TA/3LRqG/sekB/YDaevbIFSaqxULT3Uycu0GK88polXlamuBgoTzoaivkK+YpVc1nIdXgDRN/fiBlP/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5790.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:56::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 16:02:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.044; Fri, 4 Apr 2025
 16:02:07 +0000
Message-ID: <c14de67b-d644-4e6a-83f4-610fbf9bc43a@efficios.com>
Date: Fri, 4 Apr 2025 12:02:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of
 percpu_counters
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy
 <sweettea@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
 <2m3wwqpha2jlo4zjn6xbucahfufej75gbaxxgh4j4h67pgrw7b@diodkog7ygk3>
 <55c89f03-6120-43d1-a620-46d8ca8aba4e@efficios.com>
Content-Language: en-US
In-Reply-To: <55c89f03-6120-43d1-a620-46d8ca8aba4e@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 9020d39c-7938-4ed5-f3e8-08dd73920c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ly90ZzVrSXVxdEN0LzBnR080QUpiamM5MCtHZ01xWkNnMGNnWlVwL0xPbEhY?=
 =?utf-8?B?aUlRUzR2ZHlST1h3TThlZE1kM09UOFROSnhWMzNwSVhLcmtaWWpZNU9WSnRk?=
 =?utf-8?B?ODZqcldmTThyMkRHTUFjNksxbmxCOFFtYiszQkx4TngyZlhjYkJUMVJUeXdO?=
 =?utf-8?B?U2d1ZUpUYnpVbzFkS05JL3htS2R1TWo3WDhzd3J3YUplTFE2TXBNL1llemV0?=
 =?utf-8?B?Qm5yTmJLRUtZYk1IZ0k2N2N2WXA5bG52NjNRZlVucjJtcTlxTlhHNWZsYmFH?=
 =?utf-8?B?UkZYZyt2ZmxPMC9Dd1o4L0VqUGpYVWRXeTRwWlNTNHBQR201Wkh3N1U2ZnZM?=
 =?utf-8?B?MTJtRmdyOTY2eDA2VzNlajZKZTdHVHdmRXZhYkEwVTg2LzQ4UHpETEJCaDc0?=
 =?utf-8?B?QlY0NncwRDhWZXNxUDBjdTJlcC9UUlRKWkNpRnJ6VlZtQ085cDcwYXZPWVQz?=
 =?utf-8?B?eUtkNlNKWm1HNW5oeW1Gb1Rnc3I1Z3JyV2pEMXVCM3R0azhSSmNQVG5HOTJo?=
 =?utf-8?B?MkFjMHk4bnhSZWg4Y0RZdGZnSlRNTzdEVVhQNDIrcGdublgyNjU0VDlGZlBL?=
 =?utf-8?B?SnlScEpLRVV0b1MxK1lJc1g1N2lXTTgzbm8rT2NHUFVQY2g0aUFLTGZjUURK?=
 =?utf-8?B?ZFFPNU52YUlOR2FmY1Nxdnk3WGE4eW5BNjhwOHUrbVRPbzFpRzYxZWY3eTRU?=
 =?utf-8?B?YjhjM05YYUJ3K0NZZXliZTZHNnNHTVRMM2VHeTNnR05zY1Z3S1RsYlhGVWhQ?=
 =?utf-8?B?TkJsU2U5QVRhSVVyN01qU0FYZTlweHRpcGNHTVI4L1pXY1VHd3RHK2plUDhQ?=
 =?utf-8?B?Q3MzM0RMR09GM0lpck0yNEtvZTZ4R2tzZFlxaHBaTTRTUmVKWWRBMXltcEZR?=
 =?utf-8?B?WWYrMm41bGwyMG5WbjdPTnRmd1N4Vmg2aWhxN1VZUEhoRVE3TW12SVVhSTZK?=
 =?utf-8?B?WWp5TUl2SDNYSXVIakFsQ2VCOUFHa3VrZ0VtRUlWL3FOYjZrTldYYU1VMEhY?=
 =?utf-8?B?WjNtQmdrMVVmWStLR0tZK3ovczlJZm0yRERjMmZCVTFKa0xGRmJrN0VxTFNV?=
 =?utf-8?B?d3BYS0d1SENhaWZsb0ZGRm1IMS9PMDJsdXMwdEhmQnJDWjM3NmNINFdyWm9t?=
 =?utf-8?B?N0xVSjZlSm5zTDBtalpBNXVzc1NKeVJKZm9WdW0wUnpnaW9KVURUN0tLcjVk?=
 =?utf-8?B?Y1BPcFRZWjdSdkhORVIwY3E4K0xMUjR5Z1l1TmVZSEdKTVd2cGhQd0Q2WVN6?=
 =?utf-8?B?cmt1OXBVK201ais4VUd4UnYwY3IyRUZJdmpRNklZNlIyVzVRMXk1eFFKcU5H?=
 =?utf-8?B?QWNIajZySzE3QnhINGpMb25lL3RWUUVwblIvb090Z0xETjh1NE5YZEhVMk5E?=
 =?utf-8?B?TlVHWVNEMm5FU0tZc3hWeTlkV0NTdzR0RUlQMkFOVERMeWZPbWxzK3UwZzlG?=
 =?utf-8?B?ZUJFdWR2T1VpeGFGS0EvVHU2VUFlNnNmZW9YVisrQ0hMVWFFeUxGM1pyTTRT?=
 =?utf-8?B?Tm1vODZjTVl0Wm9mWmJnOGZHdUlodVBaUGJjNmNXS1pRZlQ5MkcwUXg3cmhR?=
 =?utf-8?B?VWhtSzhDNmFoeUtBUGp3VVR0Vmg1YVhrQXJMUmMxZnRTQ3VORzhsN2xsT05D?=
 =?utf-8?B?RXZYaEdqQUQ1VjV6ZjdENW1ZV2JZRWhwZ0dOcTdXaE1hSHFIV3pvckh6bVdK?=
 =?utf-8?B?TmhCaDBDQUNFYnFTdEhzVGF5Vk11bEVvVTNnMU5NMUR0UVRZTlNPeW1QQUFk?=
 =?utf-8?Q?cqkfnsFiZZoND3YZHwQog419qFB2UAizJywe6Vj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNHcUJLV1g5Y2JWZUMwRHcxdnB6d0hVN0ZRSndSSHNtRndqaVdmN3lnU2lj?=
 =?utf-8?B?cm9rSGpPdlVvSjRNeGNBSzJOZlkyZCtsWEIxYnA3T0RkVkJWSTdGQmptcFdv?=
 =?utf-8?B?MnE3OThXZzlDUDNhR0Y2ZWFSWTVnUVdPZGJWajdyV0lRTFVJVzQxcTRUSzlK?=
 =?utf-8?B?SUFjckowaEw5NTFLVzB0WTlZM0I4R05PaTRPeUFvUDJtN2RkanlKVllrRlFH?=
 =?utf-8?B?WFJROE1KV0dxMXhTYWF3aHBVMjNOdGdRN2U0MXZOOXhvM1lEY2g0OFJLR0ps?=
 =?utf-8?B?UC9HZkE3LzBBUXZ6ekpLME5SU1V2S3BUYXVsMW94V0IxUTh0QXppL1J5WVpv?=
 =?utf-8?B?RjJ0d0hIQVBqN1ZSb0plZzlhaEhoU1B0Q2tCOHZhYXFVV1VFMElUelNJMkdZ?=
 =?utf-8?B?cHpyeHI5S2RFS0xNODNPNmRzRXMrN29kL3FUYTJFODVOa1NFdDF3aDRyNFF2?=
 =?utf-8?B?RGEwZThKUlMrVCtJUCtBZXJLWTloTHJ2Nld3MktlakNLRGJTVzBUV0RCd2hy?=
 =?utf-8?B?UUVSbG9jRXdTeXFVcHZIekJQdTQxbUpQZzB3bWUvNnZhQ2tZczNhYUZ5UXdo?=
 =?utf-8?B?a3h1WkRYOFZPL3JwUEVuWEEzdkxwdUhuYnp1VUFYSlRLdFpPalNPV3J2OGdM?=
 =?utf-8?B?cERhTHVPL2lOdGVjTUgzWFVFajh4d25VSGExbEdKYXdZQXl4RmpJRnZRN0li?=
 =?utf-8?B?eHd6TkpTT0hEMjBTM09POUpNeCt3QXZycENiUHRHYWNxbWZwZHZTeGdSZnp4?=
 =?utf-8?B?U3B4dEQ3VDZyS0tMb241R2NNSDFzcEwxT0dYZ0QySnlZeSsxQldoVDM0S0xS?=
 =?utf-8?B?eWNjSjJZYmRFclArMTQ1c0ViclJqU0V5N0g1YVJwNGJjbVQ3aTNDbkNjR2RO?=
 =?utf-8?B?RG8zcGttN0ordUtYZXJkVlU0L1hQQUp3VGtzekZsWWU4NllBKzhKdi8rdFJw?=
 =?utf-8?B?dXZkaDlvMktSVWRBSjBxcTlGczgwdEFMMWZkSGphWG5oOEphMUIvb2NwVXVm?=
 =?utf-8?B?R2VmY1VKbnZsUFlESVNWM1poR1hZNzV0UExNQ1pOOW9pOFpmRUw4dkdia0l5?=
 =?utf-8?B?d2wwTFF4ejlYWDI1T3ZaUXIvMEl3bDNMcWJGL0lqRmIweXR1M3JsREtUVk9i?=
 =?utf-8?B?R0xFY0k4NzRSZ2Y4THNudURaRFN4d2doaXB0R2RGUHRIMWxrcU03MW5KYlBL?=
 =?utf-8?B?V0s4R00rallnZU4yMjFZaGoyS1grU2xpQ0ozL2xPbFUxOUxEVmRXL0MwTFVu?=
 =?utf-8?B?UmEzUmJ3TEtoNlFnMTc0dFJhUlphYTA2dlJNV3Z3b0M3bkNhcGRabjZDOUpV?=
 =?utf-8?B?UHYvRXUrbWV3eG56eUJaemhlUUVXNmRkRWJKRmozbGc2YVRzeTYxM3dFMTFT?=
 =?utf-8?B?OUh6YUZGaUs0WTJaR3g1c3JnMFU0Zld4SXN3V0RSQWxLeCsrdmpkSkJmVWR0?=
 =?utf-8?B?c0hteTVWcGdQZ1ZVK3VOR1lUU2R4UnoyTnJIU2c3TUpwdzQwNlZhYklTSXJ3?=
 =?utf-8?B?cFRBV1RYdzd3eS9rMkdxWFI1VzQ2ajZySkRaa1NIc1J1a0NGak9obnM0T014?=
 =?utf-8?B?dUJSK0l5TWpVcVhTRWN5aUNRRHRlVU5OdGxOVXViZWY5aDdlOEhoaWhWUXV0?=
 =?utf-8?B?azc4UmlxRFExRXYrQ082enVYT21ER1RGandFMWhTUnFaN1kxaGRybUk1aTFH?=
 =?utf-8?B?a0VLcFBjQ3NNMmF1Zmg5NFJlQlBMOVVZQm9WZlhrcEZUNUR2bkt4bHk0TzZC?=
 =?utf-8?B?cHAwa3hYSXBob2crenpHd2x4SVFpY0ZlR0k0OXdZalZoODdqUHB4Skl5U0l5?=
 =?utf-8?B?ZjRRWERnMXZxVkQvSVk3bXByb1plS092R0w3Tmt4bGlJUDF5VmpHN2VZYTQy?=
 =?utf-8?B?NHVHaFJ5dm9TNmo0emZwNTR3VWZJUk13QmlGV3dFTEh1UVBtZkg1d3hBeGxD?=
 =?utf-8?B?ZllFczVyVFlkMlg2WlJDR2wxY25VOEc2ZGxxVVhOM1ZjYlJVS0FqQWJHZGR1?=
 =?utf-8?B?VDZQKzI0aUpzNGFsVFlINjVpNkFadXRqcmdLamJJNjhWV0dqWW5LZ21ZSFkx?=
 =?utf-8?B?Mmg0YkE1U3pBRS9YT2pkOUpUcEs4TnZDVWN2bkk3TkZRYkJjamxQSnRINzkv?=
 =?utf-8?B?VTdEQkQrV3VMNTVaOTZhdVB2ekY3bjlrdWFPUTVucEcvWTc0U3JVV21Udisw?=
 =?utf-8?Q?+rEMVZKbheUGVv6RXPxRXCI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9020d39c-7938-4ed5-f3e8-08dd73920c9a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 16:02:07.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlI5Dbl8FKDyn1wSOQjd7ew5JJUrsmfqxVTc1owKNVeC4xnEhqv3QyILdO8+EdE3R+dTHb9MbrhLHsb+s6+5oyiAao8d0cMBGns2cX8y/nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5790

On 2025-04-03 13:59, Mathieu Desnoyers wrote:
> On 2025-04-02 20:00, Shakeel Butt wrote:
>> On Mon, Mar 31, 2025 at 06:35:14PM -0400, Sweet Tea Dorminy wrote:
> [...]
>> I am still not buying the 'good performance' point. To me we might need
>> to go with reduced batch size of existing approach or multi level
>> approach from Mathieu (I still have to see Mateusz and Kairui's
>> proposals).
> 
> Here is an initial userspace prototype of my hierarchical split counters:
> 
> https://github.com/compudj/librseq/blob/percpu-counter/include/rseq/ 
> percpu-counter.h
> https://github.com/compudj/librseq/blob/percpu-counter/src/percpu-counter.c
> 

I've updated my branches to use unsigned long counters rather than
signed. This eliminates tricky 32-bit/64-bit overflow corner-cases and
should not have significant impact in practice.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
