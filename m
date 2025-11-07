Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6111DE4FC;
	Fri,  7 Nov 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526644; cv=fail; b=tAWNdsRHaWvFtFNbyRaZpAEDi8+AeEUE7x39/niGLEGVbmEK/f5XoQjfP1jihwKSOWmPd0ktidflxZoyyMbs9wArfDsvYfIyp00wjynFPvvIDM0Eu4QOm2/unFD/PipWfzSJsTmB+Qjyj0m1tCgUl8Fl85H/OEFgdQ8/EI4sJpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526644; c=relaxed/simple;
	bh=exXCmMS80Uaf4cJZapdJHyzcmFQgkRk3ZEJDGd1MfK0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DxftIW6+Ek40oV29TJzqKf2IghQpgZkXwU6jOI4tmwLHcQ+tBnMs1GerGvaH3BbNJx3dEh8CZphlJO9eANkZBjSQD9HyF5I1zyAgcBscXBDStk79hBCAqr9enWQulo13QK1LhfP+u9N47S+/nwgvzkVJtZdhuI55sXTjA9bS9vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jcPW58BY; arc=fail smtp.client-ip=40.107.193.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jcPW58BY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rx4kcZHJas4CimdaU7CV+OKU0Q2TkIDynSYj9AHImrjQLgbJu+7dH1CMFoKtk5h55mGfR9g9gKFrcXHejT7pfRAjywbNjd7mMHqy6f4wWofoS6Jy29Ypu5yml8+8GOo4uM/yEd2G2JYtaoweftW6A6R/rWcXtgt9916eN39ENBoDhDGApmk8HvZlvRVH8vCFXSf2s7WSxRgdmZhSukX2JRgqO+gnrjw8b/opwbPjTC1QFPmGX8h40kugrSWXBMbKYW/M7iOehJmRFVJpItclEG/GDDw+oEQbkhFNkxQOurLi65ZaAfjF3rZM/nN6Ly3ZzArIms1FLKhx7RNH/NMiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHujlZ3qnnh0z6+fjcmY90WIMb2ZxJa/Q+H52sH1cvc=;
 b=c3FkK/gMTahhsMNK9ji+H4RHUFyVDfOfsPUfXcqXb3BNPT+9AqyI5Kq3GdDaBqqQG9YM0OQkUS+b0e/ywxdEouvwfS6FYxxHS8fOyXOQIcotsXFMH5c1HjFBvmwzzC3hjBlhvl/db3BAhmM818MA+9NB9zJbd7TwRxf1lyOH8rzNGX8RWV7BrM8cZxSANKxoJGkCgU8NklBfuKFWZljOnCYdTTFNHbHDRIcKOIvCNv2wBKhNNBhPeMhkXbzknC4geJHnNrKq8GVlgn0Um/tLHSwcPlw1qb6qJyyABIh0PsKp8obcu99PLpUgB7yTtG8AfeV5lG1uNdX++P8Mg02FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHujlZ3qnnh0z6+fjcmY90WIMb2ZxJa/Q+H52sH1cvc=;
 b=jcPW58BY1bY/yA48JYzzq2PKNYb+HmWU5wIEkk+yaBS4Gw2mRTTJ2MnRWmoKax2YSnNVe7k5y/1Y7+5/5/q/fMeXX4pC001rNgq73Nx+PLjzH818JM1TpxZoFZefHI3hbME5urO9tskwn7m6i8GkPibU5IRvyaV+TJMD1PZYQ3UB5CrazmdsXkFRjrbmMqXqK9wDd+tYKHJOtyTXFiHSmGOmrxsVeT7+cOLXWRJbgu83ktwg5tv/qHtxssJbHxf2rB2dEZANZE+UzXHSpd9o60WXghVzHSGqboQ8D8mZmCGrkRGIgBauvFfaz9eu5H5n6iGb1bvZLdJkLDGTXNmMQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5471.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:63::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 14:43:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 14:43:58 +0000
Message-ID: <7732c2eb-e547-47a8-93b3-1d1b4d9c27e8@efficios.com>
Date: Fri, 7 Nov 2025 09:43:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large
 many-core systems
To: Shakeel Butt <shakeel.butt@linux.dev>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, SeongJae Park <sj@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 christian.koenig@amd.com
References: <20251031144232.15284-3-mathieu.desnoyers@efficios.com>
 <202511061432.4e534796-lkp@intel.com>
 <6hmgutxgdchs4qz6hprwsecwoygwszn5ywixxrvnereilegcsx@mxroaotaw2me>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <6hmgutxgdchs4qz6hprwsecwoygwszn5ywixxrvnereilegcsx@mxroaotaw2me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d178b8b-4ca4-46a9-51d4-08de1e0c159a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1BJSHI0U3F5aUVIUjg2Vzhlc2E2NnU5RGZJaldlTlk0bnRaYjAzbUZLbm1p?=
 =?utf-8?B?b3loUTlQU3B6VlRCeXFRbzdQMWVaZDkyTFlYZ3RlTHZLN3FCdzl1bTU4SEVG?=
 =?utf-8?B?MjhBODZjZEZneDNtYVNKREl4VE9YNmJyaTd3SUlQWEs4L0ZCRElrNG9RZktF?=
 =?utf-8?B?dkU2em83bjRyZlNFaytCOVllK2kvOXJQSzFQQVhlUnNFUFU0SE9laGVxWU9H?=
 =?utf-8?B?Q01zckVUbXFaOUE3SzB5diswUXE4NnBuVHFoRDI1dHdIUG83bk93Q0lOeUQ0?=
 =?utf-8?B?V2J5ZUY4V2FLc1ZJWlpNMGpxUlRFOEtEV1VoOXpiYVRTSVBBZ2pXVVpHMm9G?=
 =?utf-8?B?aXpEclQxc1ZXbEdGU2dLbFpNSUt0OHliNHlmekh5d2wyeXR1VW1Tb05BeUwx?=
 =?utf-8?B?L2xJUEhsT0lqM0o0aDFZQS82bDNMc2V2ZUcyc0pxZ1NyOFlSUFVKZlM0OXdI?=
 =?utf-8?B?TWUvUnlFRFJnYUlneWFTOTRhWjZyeWROMStkZ1FlQ1hWTVFxNXJSTFZVLzE4?=
 =?utf-8?B?KzFsWm5kekhkMUMwZTZCTldYQStnSHFIaWZpT0tuaXV6MGpoOVNUd1RIMzht?=
 =?utf-8?B?ZFdKd0lIYUJWb1phcHZrZEgzUmhLMDlLcHpZMU5FRG5MOCtuQXViY2V6a0Q1?=
 =?utf-8?B?MGNwV0lRdzZTbTduenNzS04wMmxNbmNJRHYvWnNCSEk4eWM4K01adzdMcDRl?=
 =?utf-8?B?dDRHMDd2Nks0S0ZzY1dYVmJvQ1Vwd1NDTmdlMUhjUlU3bDZJWXUzMTkveWFk?=
 =?utf-8?B?ZXFCMk1nUFl2ZDk5YVA4b2grQ0xia29SYmNyT1dGU01wU3ZVbDdEOGh3Y3Mz?=
 =?utf-8?B?WklqYW13cktOVDNLMXVHUXY3VmJZVTVMWEg1Qm9iUThVOUdrUFBSQUNtK29P?=
 =?utf-8?B?QlQwdUhpRHZCK1BVL2lySlc0WmNMSjliZXhZN21pQ3BuM09CNHpOQlhWVnFP?=
 =?utf-8?B?MXBCMVgyeG5GRlJoOFdSQndGMFI2eEprMWorOFpXeW9uWGdnUzBGdUpBSG9N?=
 =?utf-8?B?U2prMHpLVUVHdzZjOEFXcVNzMjNKa25LZ29aMmdiVFZCdnRuUzlVbFh5RFNr?=
 =?utf-8?B?aTV6UFhtYis0WjAzTXpRQmFQQm9ORGQzWm5LS08zSEk5cURNdFk0TE5EM2ZW?=
 =?utf-8?B?THdTVkpRYkxIeEplaXFPbFV4VnRrZytvVUVWd2lzd2VtS2liQW5SMXhWWnBB?=
 =?utf-8?B?QjFtWjBNajQ1UGxmYldtaHJaWXAxL2htcGlXMDMrOERxZlMvWmIzdDYwak5B?=
 =?utf-8?B?eS93dWVhQi9HcGUxTThRdWF1UWszU0JnTTN1ZU55SS9pRFVPdEdLcnR3YmpR?=
 =?utf-8?B?SlkzZElscTZDeFFEbEx5dzhWOXJ6REhzQ3lTbjZqeGNpeFVvOXNLWHFwNFlm?=
 =?utf-8?B?WnhiSXNLRE5VMHhteDg4NHhSdEMycHZ4RnlRN0g0N29VRmVla2Y5SjRpTDJC?=
 =?utf-8?B?Q1VCVCtSbGlxa0R3dmVzZlpScThlQzR1amlWN01HZEMxNWhkSnE0WUxSRm84?=
 =?utf-8?B?UCtpTFVValMrODRhaTd0UTJBbzBvd1lrZjFhNmwyeWlQZTZ2RzQ0enRMNUlM?=
 =?utf-8?B?Szd0eElrRkhoM2lVbFkva2IyekE5UENFM0dCU05rNmQ1bmNFU3FXdFhSa25y?=
 =?utf-8?B?Wi9SRGU2QUQwVjgxTGZYSTJJelovL1JROXBoNmZWWkplVHVoM1h3elREU2J4?=
 =?utf-8?B?T05SbFZWak1nUnZiOUIxMURpd0lRTE1jMGM5WkluZWZGZmhBbkZzZkpQQ0pI?=
 =?utf-8?B?MjFuS0dJeThseGlmak1IZjRBS1QwQTVsZHB6UHZ4akRLRGpURHdSNmZ1eFBC?=
 =?utf-8?B?L3grZ1gvaHQ4OW45U09QbU5ZWWxPVkZKallxUzFKUmxoTGw1K0ZOYVY1UlZB?=
 =?utf-8?B?dUlrL3NSbXZDTFZQTmxyUW5mY1pWbXgvQkZtVzNQOURkTFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnJPdGR5S2ZLQ3JJelFJaWk2NGxpRDg1eEVZTG5PQUVYZXVLVWFCLzJNUFBP?=
 =?utf-8?B?MzE1S3dtVWYzMTl3RmN5NGx2ZWs5YVRESDRpNk81Myt1TS9rclJuZ3JjT08x?=
 =?utf-8?B?d1dBdFM2S0FaMUZYSC9ENmdHRWR6SDF4OEtCQSsvSVZBbm95UHF3QzhXUFlx?=
 =?utf-8?B?MTA3SzBEeHFQd05FM2ZiZmMrT0tOQmJSZVBqcU4zTXlHamlXSUJqRThTVHk0?=
 =?utf-8?B?SWJ1UVZ1cnZXL043OWUrMTdhbDEwN2pmbFZFb0lRL3gydm9oamhIc0JYQzJk?=
 =?utf-8?B?RVppRDU5Y1lRMy9LZnVKZmV4TFpTRy9CSWpmUlZ4Yldid1dSOFp2N3VwNXNh?=
 =?utf-8?B?R0wvUGVaOTNOOTlvamFsMUxEaCtnWUNxVjF0dVdheFQ5OW1pK2hINGZSYURx?=
 =?utf-8?B?WjdYM3FocmdRVDNYSWV6eElqRSthQnhWbFdoTis0L3BpTktiT1RScmxnMEc0?=
 =?utf-8?B?RHhKQ0xNVU4xZ2VuYXZGWG5id0dFNmdEclU0YnNHUW9pTFVDeTZCVVB2SnBY?=
 =?utf-8?B?aXhpd3RQMTdnRi9WdlZOZXNOMEo1dVZYcCtEYnBjWG0yc2xNTGxWY2UvSHl4?=
 =?utf-8?B?eGtyckVXa3AwdVJ1aW9UODJ1dmhEQ2pJeGtUVmVvVS9qUzlFQ1R2NlFGWk5N?=
 =?utf-8?B?SzNscWpGazhPUVR0QnJYcEM4WDA3aVJXa0Rpc1FYTnN5VzgvM0VvL2REWG51?=
 =?utf-8?B?VTJpVGtUMG9OSXhSREhEV0pKZ0x2cERqVk5XM0FLSnY4NXVRUllJZnRmQ2tr?=
 =?utf-8?B?U0NoekxCR2JUSFh3R29FTFVNa3NCTUwydTk4NkZPbDh0MHdQeGIwV0dwWVhU?=
 =?utf-8?B?ckFSd3hXbjZjaFBVUWk4LzY4cVFIYTk4cktZNnFVNENIZDNiekU5cWQxK1B5?=
 =?utf-8?B?aHZvUHBIYzR5RnZNaWQ1YkFlc1MrdGZwNHllWFRrTEVLNVRoTVhGY2lYOXEy?=
 =?utf-8?B?UStqUTZ6RHFRVGEvOWJPVHhiOFdHeFhaOWo1dWJ4UldaOG9KZUlHendWUDFn?=
 =?utf-8?B?T1luRi85cVJOS1MvL1FuR2JFTVlseGMweFg0NU5NRUJWSTBtbERQWkQ2VGtH?=
 =?utf-8?B?TUdMZ05IK2VIbVBEdHlpNnR4eTMrMXhQZXA1Z3d6bWRHaEVOTFIwdm9LWjlQ?=
 =?utf-8?B?UGZlWGJXUGlSUXN1RklwbVFzQ1Z2enRPZGhWblRNRmNrQ2o3ck9KQVlEY0F5?=
 =?utf-8?B?UnlHdmRqeFgyazhtM0IxVmdLYTMyYlVUK3h2MmdGTlZXNWZSaVBKQ3dRMFZC?=
 =?utf-8?B?V2xVQmVSbDF6S29nSytramxXN1A5T2t1Z0Z0Z0FrT0FwcHBaZ01uNmo1OXRo?=
 =?utf-8?B?MmQ2d0J6ZmsvUGZnTVIrRlJwS1d3T2lxYUpJN2orT3NGSzRBTU1tSjhyTzRY?=
 =?utf-8?B?QStoSkRSZHNtSWR4cWRLSlNqZSs5N0Z0ZUpaS0t4R3NCMm9oOG5SdWVWL2ZM?=
 =?utf-8?B?V0U4RitHdm1wNmQrRzRHQVFaazVaZUFnRkZ0VElTZSttYXZHOHFHTEowelhE?=
 =?utf-8?B?UVRLckdvQWV6NmlqZkNnYnZGeTlWYzZxSy9ValVsU1hVeTd6S2NXRFBMSUFi?=
 =?utf-8?B?YmVwOGJVNHdrY1NIc2FWaXRnUlIzeFo4dWlQaTFOMHMxYlZybE9jL1Nvc0Uz?=
 =?utf-8?B?emRCY2hPN0pyN2FONkNxNDJrNy9DL0dCOHJmeDYzMXV6bC92NWN4czErbVVk?=
 =?utf-8?B?RHNsc29aV1I4ak45WVhoOUV4QjdidFE1L2ZNY3lrUmVoZ1BmeFo1cVFjZnlw?=
 =?utf-8?B?dU5UdDV2clVPY2ZZcHM2RHJvRDBHbzFOb1hyZU81eVR5ZjNiNW9pYzZSSW44?=
 =?utf-8?B?QnliVDJDZmMyWXBIdEpGdHM5cjdsUnBGUTdyS3FzclZ0Smk3MmEyaGZFMkdP?=
 =?utf-8?B?MXF1QUM2WGw3anByNFd3N0VYRUNZanRnZGhlMWJ5STZmSzJTNks2QkhuVVBq?=
 =?utf-8?B?aFYrMUZwckcra2FFb3B0YzR4b2kxSzI1bTIwZTFTWkxQc2NkcVIzeDFiTDRG?=
 =?utf-8?B?L0lUa3Q4OXgrdTRxYXRVZUUwL2pHMzZiWlluT1ZUSGtFeTRQWE5pMndGQzVW?=
 =?utf-8?B?RGVWUTluUDRXdVdvUEkrVFVlWEhzZmFOVGd6M0xXQzgwVnZmR294VDhCcEsy?=
 =?utf-8?B?MmVrWGlaV1c1d2dUcmlTS0ZZSnBaK0pnMFlVQzZKL3NFS0dnRWVRbmU5U0VO?=
 =?utf-8?B?bWxoMEZzdm5RNy9HQW8vOEJJcXJUYXFJNzZ3cnNoSFlVaHVkL1JKSTk1MDBw?=
 =?utf-8?Q?CRO8WhEwrLAHjP4/oU12O/dFDksB58xWbM6nwIxCWY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d178b8b-4ca4-46a9-51d4-08de1e0c159a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 14:43:58.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grXDZnyqJoGw2SACbJeHO6sn58ybImqkoNgUAuZ2VywxwOyCAvLjr2TopZOxJ59orYmH6EoN6fkzwdI8iWDRAtNYhWuJO9RwXh14Bc+wPTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5471

On 2025-11-06 19:32, Shakeel Butt wrote:

[...]

>> [   14.858862][   T67] BUG: Bad rss-counter state mm:ffff8881000655c0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:67
>> [   14.894890][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_FILEPAGES val:0 Comm:kworker/u9:0 Pid:69
>> [   14.896108][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:69
> 
> Hmm this shows that percpu_counter_tree_precise_sum() is returning 0 but
> percpu_counter_tree_approximate_sum() is off more than
> counter->inaccuracy. I have not dig deeper to find why but this needs to
> be resolved before considering this series for upstream.

I notice that those BUG show up while loading modules at boot in kworker context, e.g.:

[   14.858862][   T67] BUG: Bad rss-counter state mm:ffff8881000655c0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:67
[   14.894890][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_FILEPAGES val:0 Comm:kworker/u9:0 Pid:69
[   14.896108][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:69
[   14.918858][   T71] module: module-autoload: duplicate request for module crypto-aes
[   14.919479][   T71] module: module-autoload: duplicate request for module crypto-aes-all
[   14.920801][    T1] krb5: Running aes128-cts-hmac-sha256-128 enc plain<block
[   14.921844][    T1] krb5: Running aes128-cts-hmac-sha256-128 enc plain==block
[   14.922852][    T1] krb5: Running aes128-cts-hmac-sha256-128 enc plain>block
[   14.923843][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc no plain
[   14.939591][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc plain<block
[   14.940614][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc plain==block
[   14.941586][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc plain>block
[   14.942547][    T1] krb5: Running camellia128-cts-cmac enc no plain
[   15.018568][   T85] BUG: Bad rss-counter state mm:ffff888160f81340 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:85b

I used "module_init" similarly to lib/percpu_counter.c, but I think it
happens too late in the boot sequence:

   module_init(percpu_counter_startup);

module_init maps to __initcall within a built-in compile unit, which
maps to device_initcall(), which happens quite late within the sequence
called from do_initcalls(), called from do_basic_setup().

And even do_basic_setup is documented as:

  * Ok, the machine is now initialized. None of the devices
  * have been touched yet, but the CPU subsystem is up and
  * running, and memory and process management works.

which clearly requires that the mm subsystem is expected to
be ready at that point.

It probably was not an issue for the non-hierarchical percpu
counters because all it was initializing is handling of CPU hotplug,
but the new hierarchical counters initialize the pre-calculated
inaccuracy value which is used to figure out whether the approximate
sum is sufficient to compare values or if the precise sum is needed.

I think this is why we are hitting this BUG.

Now I wonder where I should move this initialization. It requires
"nr_cpu_ids" to be initialized, and pretty much need to be done
before mms are created. I'm starting to suspect that the module init
code can spawn kworkers that have a mm before the init process runs.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
