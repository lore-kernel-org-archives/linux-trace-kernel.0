Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020138.outbound.protection.outlook.com [52.101.189.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B874257851;
	Sat, 22 Nov 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763846815; cv=fail; b=SRskKDV8Ki94kA/f/9U8Ff62fu7iIV4s6DLwaxRbNezWkicA5xQBJ0ThwbzuN70W8q1A7pSzm7IUaD+nnOYboayKE7KwSDZTAWQRLyH3xiEHThYSboa1S0M/X0ghd3prwsg819STy1W221L5E9MXyoIV6UwrTLuh9r2Rj5prRNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763846815; c=relaxed/simple;
	bh=qTLEXHqYQGRMWpOCQVfh1fwatuSLvSGsGkFFlyXI25o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OIrrJFIpnbu2nzF95gbRQaTVNp0GTF0jEMlwPYUFVEGs14ZOFqhuh7bjs3DfpgQmB5TeSLIUdIR/S5EbNFARH1Pl+0ffeGheJrCsroXy0g1fNJhhsWF1u75pHS/X0IItWLCDOsKXT1lPJlfAgqxIkQv8BF1HH6a7Ig3Fxhs8mXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hMstoJMK; arc=fail smtp.client-ip=52.101.189.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hMstoJMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDIrtaPxRqJXGgxDoFyYGn4ASD/Lp5vh8UhdO+b6xoshPxMX3NxS+xhkUs+LDQW4LYVmYWX+CUK77dTFe/Wc+2sbundira0uywurnU+/uYTAe2ZafeAR/5X9DsS8ziSWuTsvPUpuBHqhKc6axajgwCQc57Z3YLj3htUMdPr9Y/x5sSthYXZiDazU2W4zqizKEaR5E5czdACnQUg85YP3AADEREGnc0mBalZy0RnYOeAHxrQov0r8xHG38pOZhLc7qarvxwPtG03hAyUdOhC2zGqEFJh1R0WuUfB3vPMUuKeeo8ndqHsjP4N80zCDdYTDe8ddKCjrodVXndkkvOW7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hykKQCuZ2eIhXReQYlOZ02Qc0g6cKm/Sss7742mrWZc=;
 b=TwwvqFXK/ClORbpEGk+sOUIsaqqaZhnDUh0MDaLGqg/sAnPyvjDH56GvZZYsK/VIo3CnrhZdM3K0Uan7Wks9lKUpatcvSMy1pHRN9TnrOpUC8br/HQ6foBBc7B2ZdsDa4oYo6FQyOAAoUw3ZPxX4jgaqAxD7oEUVYkYPsebHgb4lq/GEQWgk1ZoeAuKOchGrgElzjawxj2NazVszn68rwZ4kr/QKSj6eFFZzBMii08AVh0INcCs1ed/WGx1Bl75woyR6E3TH9tLcein5rjARQSxwivJNiL58ReDqWCJrstvhP/aKygbJ+cKbUNBOLb7QOm85VvPKvRYAffs/0Czu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hykKQCuZ2eIhXReQYlOZ02Qc0g6cKm/Sss7742mrWZc=;
 b=hMstoJMKIfnP1WZ7i0163P0ICaUX5QmH301Mc6cj9kxVcoDQg5OYrIOZ+/Fspsf/AZ4pXaewcg8lDx5CI1n5Yg100QvmPge1GJ3MfZuHoFRls4p/4Sli1NR6Ha8zwvGhBB3+9g+eAjRND80xG5CRcpEIajLizu0wAI+OgegP//T+dlYu4qWU1Hd2OR33KrfEHrqYumKrPyVv2LHkc63lJvFH2qL2KAlwUpWuVyL0nZ6m1ywjRf6Gk44N3CVZT0rKsMu/AvN7hSt4Kub7s8tLTv99zHq4lxxwBVg/15Hv296p+6AWMwrmH1Ws/OaVX0X5NvN5UV1yTSDrl/CllVtXXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5512.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 21:26:49 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 21:26:49 +0000
Message-ID: <c8001c6c-cedf-46c8-81e8-ac27f0d0f0a6@efficios.com>
Date: Sat, 22 Nov 2025 16:26:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] lib: Introduce hierarchical per-cpu counters
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
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
References: <20251120210354.1233994-1-mathieu.desnoyers@efficios.com>
 <20251120210354.1233994-2-mathieu.desnoyers@efficios.com>
 <20251121100308.65b36af9e090a78a66144c6c@linux-foundation.org>
 <a3652f6b-cd3b-45ad-a3ad-e92369cf4068@efficios.com>
Content-Language: en-US
In-Reply-To: <a3652f6b-cd3b-45ad-a3ad-e92369cf4068@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b07b503-d54a-4b17-5de8-08de2a0dd876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NndnYUh6azQ0MmdxT1JzWTNTb01zTkM0TEs2TkdSYVJIMFJwZjR0bmJUUHhR?=
 =?utf-8?B?VVlWVXM2MVVnNXlDdkpscGxJRzBMNmFScWhLUHowdHpSZkNHWXdWelQ3TXMz?=
 =?utf-8?B?azVkTGEvV2pYT1VIeFl0U096WTFtdk0yNy9PaXZLYzdXWjI5S1JHNlBzNCtn?=
 =?utf-8?B?TklvVjB3WEN4WGNCdkpGSTdMWm5vWFVIcER1WkhPeFdaUnQwVDFQdjMxOVJx?=
 =?utf-8?B?c0Y5VUdkZVY0bnc3cnBPaEdpSVBmOVU3L0UyVWRyQi9GenBNUDRINWppUkpa?=
 =?utf-8?B?UXlDTWxEN09tQlNxR21wSWN4UWhaZ0xOaSs1Q2FkN2psT3FhM1RVazFkTnhD?=
 =?utf-8?B?V2w4QWRINlRNZ0tuQjFiU3dTODA2cGd1Y3Z0dWdVOG1LZUt1bi82WnBCT0tI?=
 =?utf-8?B?eGZ5VkJsOTNtbkN5UVpXZHdpSDNwR1FndzFPdXNUckVvWXJnSlhzZnBYeWxH?=
 =?utf-8?B?S1BzKzRYYXUrRHQ1Um1SYUVPTmUzWFBaQUlEY0lJRkh2TnUrUS83NnJBbTd3?=
 =?utf-8?B?Tnl2UWw5ZHJtWFVFdXpUditDWFNuZVJUakYwR2dZaWo0WWVwcjIybVRzZVNG?=
 =?utf-8?B?SkRzdWpkTVlrUmcrWHhLSmhuSmVBRFQxckI2RlgxdTUrUVZwdjdFNGtoUEll?=
 =?utf-8?B?N2hLckRoUGtvZ25KdmpKTlphek1qREtBeVhTU2t4MWIrQUh5YVo0Q1NFMnBR?=
 =?utf-8?B?RnNOM3ZSaE9sa3hEU1VLckR1bGFlWllBRE5VZkFGUnZGOTVIMzZDaERtOFhL?=
 =?utf-8?B?RUpPZW9CVzFRaVNzYjFneTVtL1pzNjRQbmhJOVh4eXYwRXBRN01XbmprV3kx?=
 =?utf-8?B?aFNiMmFNd1Mvem1RN0tIUFFLcWppbnQwZXhTVTU5d012T1orOXNCVmRxOHp3?=
 =?utf-8?B?RGRNMkVmb2xibjR3eGhYZDNqa2J6eVhxeW9iemR0SXh5d0diQ2gybEZjSlNZ?=
 =?utf-8?B?V3dGKzZwbHpMS3BIdm4vb20zWUJaWGE4Wk9FZjR3SFJaQ0MyQmp2NUxNdXNh?=
 =?utf-8?B?RDFZV0ljbFNRR0NvSzhKNU5aRkVtUU9MeWVGRjdTMkFjOUZHb0U5bUw3bUhL?=
 =?utf-8?B?Mms3bERMUGNIQVBDYVFub2E4RHViZ3JsNWVMK2tpMVI5OEM4eE9nS2U5RjVT?=
 =?utf-8?B?RmRtMUR4eXdZdmpUWExtUkpja0VhSjhYMWl4U21BMEJIUFBoelRSVFpwQmJh?=
 =?utf-8?B?cEN0UHZFYjdYdXpkODU3T3lOV2lJcy9WOEEyRDF5bzFFdzdScHpvN3ptUjZo?=
 =?utf-8?B?T0JxZjd6Skx3d1FUUEREN2tvcC9WaHJTTHI1WjQ2dnRrNm5wS3RJMldNZzZr?=
 =?utf-8?B?NUJBN3hURlBmS0FOcVhTWFhFVFBzV2JkbmVzMkdQbDZ4dWZKdTNpWTRtbnNn?=
 =?utf-8?B?dUtTT0x1NmhzSm53TGI2KzNFdGNtOGhoS1F1S3dSYWczYlNubUNkeEZUTXhk?=
 =?utf-8?B?anI2ZkZ5eFhYdE5jL3RhdXNaTDBMNmY5Z1huVjBaa1YydEhCazhxU29jN0Yv?=
 =?utf-8?B?MDhyQ05iUko4VEJyRnlZTVgrTkRYeThLWW5XQUk1UWFNeCtUNnFRSng2ZHMy?=
 =?utf-8?B?bGxBb3NVOHdzNDVGb0N2Rm94UUNVMzBVbEVQUkgwckNCVHN0ckxhUVJBQmo4?=
 =?utf-8?B?RlJEZXN3UTBPcCs4cFdpd0poTzFDSWRYaEc3eFNxcE5qREFrUDUvWFRFK0dm?=
 =?utf-8?B?S05WZENkVVNER1JWVmFVRWN4VDBGYXJlM3FCb3dEbEQ0VWxLM0Y0Q3lSdkFB?=
 =?utf-8?B?WUErcmd2ZEpHd2VmQ3VrNlV3Z3dDL1ppUCttRDYwMXErTjhXTFZObjUrVnAr?=
 =?utf-8?B?MXRwa3FjYXEyZXF6Snkrd2F6SVhUbEU0NkJlUWs2dHdwbVczYnJDeWxVVEti?=
 =?utf-8?B?QjR3K3MyZndxaWVESmJQV0xwN2lOZVpWVjB1V3V2b2E1NFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZKcnVRMFlzWUhwTGdaK1kwZzg4UUVEZnN2YUpINkN4RXg0T293dTh2UmZu?=
 =?utf-8?B?YnpDRVkxZnRPaGJWUURrTVUyUFFtRyszZWswZnh6aGtHalpGbm5zREtOalJU?=
 =?utf-8?B?c1VlNEJjNGs2WFk1Ynh0ZGJua2QraGdxTzZqWU53L2RxcUlxY0d1U0lEQWZR?=
 =?utf-8?B?Q3NzcEZJMnlXVy9mQ29NbEVaSlkzaW5UMVk4cTk2ZTBqR3JZR3RKVTBoSVI4?=
 =?utf-8?B?TEgzcFpxdmNHcnVBSElEdmlMNEMydDRORGRIcVRETG1hQk54VzhMdFJYN25n?=
 =?utf-8?B?T0prdnlUTFU1Z2JHYnpDTkVaRk9udStTeHlpL056b1E4bituUFNUTXgzZzJF?=
 =?utf-8?B?U3VwQXhxeFg4U2tOYlA0T2JYWlNDeDZjV21Uemd6VEJHVWJ4SHJNRmdzSzNZ?=
 =?utf-8?B?dnJ5Vzc1dCtGZEJMdmtOZWtkcldjek12S3RNVGtRMjVRcHNOZGZIRjVNQU1B?=
 =?utf-8?B?TU81Wk9rM05JZ2hTNHo0TTB3N2lvb2hmSkFiMWN3aDBtanBCbmJyQU51anQ4?=
 =?utf-8?B?aEcrWkZsNTVwNFE2eGNzQUZnVW5SMmozKzhLY1YvbEFERit2RUo5UXhuNjZo?=
 =?utf-8?B?eWN3aXEwWFJSMTNoQlBTS1Z2YzZoR0dRUkY1Y0FQRUdpeG1kWTBLWW5majR5?=
 =?utf-8?B?TWdGaWN4WWJsRVRwUGZETHVRbmYzRXBub0ZmdmVWcnIxamxkcXdpVEdsL1Uz?=
 =?utf-8?B?bkVJcjMzU0hYdUViaEUwWG5RRVlMUnlmaVNNcGxiUGg0TWM1ZHkyRWZubnow?=
 =?utf-8?B?aTdVSTJWOS84UUJvc29RR01ndnIyZWlrcGFvNXB5eEtYMHQ5aFZEM29PMUIy?=
 =?utf-8?B?Z0hLeFdDWnEvZmtvOHlNcDZwOG1peGZZWWhBbHdqREEvUFU0eGdVSkEybjBs?=
 =?utf-8?B?N1luTFZhYlMweFBvYUIxT09LMWFvYlAwUTFZODVIUjhIZmZVVmZEaEdaZ2FH?=
 =?utf-8?B?V1NwQ0FSL3Z5V3dWSGQyN3doZE5pVm1aU1lUMVFHRlFkU1FBcTBUL2VFQlF0?=
 =?utf-8?B?ZFRlK0FrT21ycGthNFpXSjY3S1RueTdHMzRXbXMvZ2x5OUdvK1JyWlR5M05G?=
 =?utf-8?B?SXk3c1NnN0hqaVlic0xuUkkvY0YxSVUzT0JuZ0lUTXIwOTN0akE3VWNrNktj?=
 =?utf-8?B?UmwvWDYyemE2M2txOU5hQTBnSGtqVUlQaVJSVXVvRmh1bFpRUk1SYmFrZktu?=
 =?utf-8?B?QjMxaUZ2RWJpdldhdHhOZTh0ODBpYUVxZlZRbGJDekxEMTVISWVzVVA5dFVJ?=
 =?utf-8?B?WFB3RUlpaFJkdHdkTUkrc0lGdTN2bGZ1ZU9ibVIvdk1GUmRaelVaKzRscGM1?=
 =?utf-8?B?akRSMy9pSVlQZ1ZJeEdWNEZHc2RwWml3OEk2RlhRbUZhd08zU20yRXMvSG13?=
 =?utf-8?B?TDlTb2kxVnJNRDQwK25DSGMvWGRhMGlmMnZ0M2thTmZQOWkzcnFUMVJ1enor?=
 =?utf-8?B?YmZDVlpQOWNkVFJqbGg3WVRRN2tqVG01OGZIU09Dd1RuVVIzSVBIQzQ3alR3?=
 =?utf-8?B?djRhNEt0bHFwL2szVFdBRGN4cmxTeWF1azBiSkNYZUFsZzZnQUdFVkFpVHRz?=
 =?utf-8?B?YWJQVWlQY3JSbWFYTS91aVQ1OC8xQnk0US82M2hETjJjVE5FcERFaUdtT0dY?=
 =?utf-8?B?Z2VNeFdZdXA3NFVhYXdqSkNiOVQ3OHdMZVdZRko1QmUreDFoc09GZXJSRm51?=
 =?utf-8?B?SEE1MWgwVzVRbS9jYWZ3ZDAxNndPVzRiUVBFTHRZK2xZaWRMV21IY1huaTVv?=
 =?utf-8?B?OUFhcW54T1FqNGx5L05zK1Z2QkhvQXFFUDM2dEtaQVJ4N3padXRtcXNtTGpK?=
 =?utf-8?B?MExFS3hZdGZ3bWNQQVA5aGpQNjc3MENTNkxOMDdmKzVOTHBsc25Ib0RVSFVG?=
 =?utf-8?B?bUdaMWE1c0prR0cxSHE3R1R4K3hOZVlMdmFGRHhkQ1RxZFQ3eWFvYXZYc09l?=
 =?utf-8?B?Y200eW5mM3Z3QnlmYVJTUFBnT1BDM1VIMWRQWk1LTXVQbnJ1M0MxbjdQTlV4?=
 =?utf-8?B?bmlJWHRDRWFCeXFXWHdjb3RzSXVJVE13bmR0Y2ZxWk1xeUtuc1hlWVpFNy9w?=
 =?utf-8?B?MERpVnpZcGZaK0ljNE0xYzFOajh3M3Q1ZFNEOTJBRXFOSlprM0gzdi95SzZt?=
 =?utf-8?B?OE9WVUQvZ1MxZWNYNE4veDdYaFZCQVloV2s5WXphaEZESUxtZFl1SFZseDlo?=
 =?utf-8?Q?R0GCgdkiEZtQn7iRFuDxJdA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b07b503-d54a-4b17-5de8-08de2a0dd876
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 21:26:48.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klUc6QaSadqkLQzva2IvASubHKlnqnc5pvX+e3zT/aA4cE6ov/42/VIdH7HtzlRH/4ptZMN+GgnTgQQC0KGC/rXx/WydnVir8ycrQFv4lQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5512

On 2025-11-22 12:15, Mathieu Desnoyers wrote:
>... 
> The fact that the max inaccuracy is bounded means that we can perform
> approximate comparisons in a fast path (which is enough if the values
> to compare greatly vary), and only have to do the more expensive
> "precise" comparison when values are close to each other and we
> actually care about their relative order.
> 
> I'm thinking memory usage tracking, runtime usage (scheduler ?), cgroups
> ressource accounting.

Another use-case worth explicitly mentioning is accounting the
resources (memory, CPU, I/O) used by a given entity (process,
cgroup) and enforce quota validation based on a configured
capacity limit.

This is a comparison with a limit which can be much larger than
the current resource usage value. Therefore, because the inaccuracy
is known, it is possible to enforce the quota limit with an
approximate comparison, and only use a precise sum when the current
value is near the limit, and rate-limit the frequency at which precise
limit validation is done.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
