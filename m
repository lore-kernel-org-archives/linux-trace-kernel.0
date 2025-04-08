Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022081.outbound.protection.outlook.com [40.107.193.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1F4A1D;
	Tue,  8 Apr 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141233; cv=fail; b=pJN3caansFFkJPh3/6p2Yw30s4KgQSSTcnmx6YFKK8ckAaPcSnuG69siyMt6mZMEURjkRSsqq7LtBD2IP56pkF2bPOCn8tpHAjQM3w9Xb7AsjDus3IahxXfqHpGstxJOp3hukjVXQ73+ovjQiDmvgicaeNU1jv6/eR6sKcBhCGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141233; c=relaxed/simple;
	bh=QHPVlhZZCbvsNTUm72AYYlVj2VAj/XbYaFis/6SYk3k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=loXKD9l8NGRz4I1CjLZ3PsItxh8R6eiX5RvZKkWocS9AdqoUsP7GbLCiexkB6x6HUtH0XlR+SygNpvA2mFwovpaBDYr8hLMxiMLArJZ7uPL+RsNq8XJdzp+s7w9r48CDp1kSWqa4i+Yo9H2Ksbl8uya2MUWfwa3WNa2xfPNOMGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pWglLrON; arc=fail smtp.client-ip=40.107.193.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pWglLrON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezeWhfeaCi8/GroQaRFlMtSoV30WkIeQ918aJZxZS+NgwTjuQMk7gGG9fuzX2roc0Z/F2IihjEZPvjmgtT+ySenvu6btuLAO1CdzU1UHDXW5ZGUqH9tm2ixE+siw/SALPq2GODX8UaEJWOcVy8+++UZvyJKfpNMUk65ycWeyUDexRGhflTJm4yw1muF2OzSdiKcNItQ/I03/EaUJ1joH03fBlKYTyrx2BErECo75Fy8KfS7YiLae0thrEfU1DEppWkWRgc8kaDXI/blVbjbi/g1E7cv4jebVnoSlLsuGDbb64mJ7XCbPknAplNrN7Hvk4G3g528HiFXZiC+eyvn2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOQwo8PI8QWuPvl8q4MJQvEC3QySPz5gZOJpHcpqNys=;
 b=YeUBPeyoSLk7rbW1RxR6Y0mYjtDTV6gTgzSBOQrk3IKUGdx5/v+7Nb6cc/LxOPScO96QMEqzU7WEo1ljr4oqAUl1sxMWQ/coUWIs0O4z57fS+QVdH+HXBOx1gs++HYfwdAaNGRAzCJOszP6x0y/zrcuOadeeryo85z0s/oRGRvdGQ1vh0jflEpWvdro7wmuVvT8VIsautuQSizYcvHarDUzjJhxY11+W8+2UuaeW1eDpyvB0VU1b12ad6AoWmvH2B41iCayfUeSzcic0J69BKvbv89lt29k1/qnh/DcUoNDpBJKaJu3yxQfDDVkRItCIhaLgm+KO3VROQxEgko0JqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOQwo8PI8QWuPvl8q4MJQvEC3QySPz5gZOJpHcpqNys=;
 b=pWglLrON3VdIS3qKFJ137u8jzTL3cysiu/FDRWipgqlfNFfQ5IKmHZtVr3hP1BNMyymEV53EbVab2EPwbiORZ8cJUbl8qVyCEYL3lLyeTGxQ67yQFdzaxS78m/UVGeS346fD2QwynjUuL1m7vLEiP3Bycy7905QGU/yR5TouhTpS1YvJG3Wumn7j6xhHeMmNpCt+COkXBQe+IaZC715ZYsWX3llhPDXr+XMGLuTXjdahnkfXz8kM/gwhx1I5OizrRBCeCytmLOfulSsvGtnwA/iFV603wFK/KyI6+LSaMkAmg/qzTXCZ1cEHAaitkmdYlYHmtvwIZzFgCTV66EySpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5498.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 19:40:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 19:40:21 +0000
Message-ID: <bcebaacb-ef9e-409d-b770-3057a96c3d11@efficios.com>
Date: Tue, 8 Apr 2025 15:40:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Sweet Tea Dorminy <sweettea@google.com>, Mateusz Guzik <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
 <Z_VWc6Z90rhfyLBp@casper.infradead.org>
 <iqa7gvbcwyw76jd6cgimp5jbu4szxob5ptjvi3rzll6amfjygg@cunm5zrgm27e>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <iqa7gvbcwyw76jd6cgimp5jbu4szxob5ptjvi3rzll6amfjygg@cunm5zrgm27e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecca54d-5fa8-46d0-62ef-08dd76d53323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW82WDVwT1VkTUVWTlBOdmlJNXJGakZ2dnZQY0NMZS92ZnJtcmpiaFg0eU5k?=
 =?utf-8?B?UEVBcXpSLzFMZVdYYS9IOVJEVy81dGFTeEtMeURaSFJuakNaVmpvWkRTdi9w?=
 =?utf-8?B?V3BEMGYrYXJiS1g2SUkwYXZnYWJ3VXV6elRqTkVXcDN2ZlVpWG9ZaDFmeVBa?=
 =?utf-8?B?d3U1TWY1SHBRdjZzSkFTR1MwU2FmeWdzRVFENFQ1SXBYTDFBK1RtaGNUTith?=
 =?utf-8?B?bjNtZ3pOWlZ1cHlFUjExM0ZCaGMvYU9RZ3dDcG10d0l1cGFlM2p2ZGE1SnFq?=
 =?utf-8?B?LzFsNXBRVWVHZGRFeXFpd1BEVjU0a0o0Y2pGby9DSjBRK01rYTBIajkrUHFG?=
 =?utf-8?B?d2NtZ2wxYUFHc2Nua1A1a3ltd09HVDdwblQwWDQ4NmZSUmdqMDVDVElhYTAy?=
 =?utf-8?B?TGFkV1RjRHRrWlM4ZnBQUWpKWFF3Y0VVSzRFVlNhSTlFTGlkNURRbGt5NHFH?=
 =?utf-8?B?WXdMVmdTM2RFazZpSnNMMTBNSmlwejZla0F1YzZ4S3d0RkcyK0pMalpDVmd0?=
 =?utf-8?B?bmFDbksyYXV2N1l3T1BiSjh4dkJzQjRudzkzalE3c2Q1d3dsSThTUU42TVhv?=
 =?utf-8?B?K3U2ekw3YVdTeURuMjZRWGlIOTFXOGRuOVRvMHZUYmFhUy80NUJqZ2F5dDB1?=
 =?utf-8?B?bnBOd3NOMjZPUXZ0TGpiaVR6b1VzYkRvNlQyUnNvbmlFbDNVR1VyUTBXNlk1?=
 =?utf-8?B?dGtWMENacFlCb2M2MHNvMC9aOURaSVFIR3JMRmcweGZNSGRJNEFrR09aeGVt?=
 =?utf-8?B?ZUd5YlBDVmVNaXZCSCtVZ28vS1duRlk3YSszbk8yYVFkdjIyYXg2TUdyZEVU?=
 =?utf-8?B?ZGhORURUY01YbVJLdWl5Mjk3R1l4MFpTOEcwQWtmd215Y0d2UHBLMTFXYUk1?=
 =?utf-8?B?MTdHTE5QYndYZ09WK0FvQVVnTUF3MHhRc0FnWDZqT2dvMm1wbXEwU2E1Zitt?=
 =?utf-8?B?eGxSeHlOeGZreUNMZUxaS1REUnl5ZUpWMmNHV0FjYkxJd01uZ3RwZkV6aXhq?=
 =?utf-8?B?Z0x3ZE92eHhwN21wcmVIOEZueks0Q0taS0RXdk9YcEkwYzA0RENJbUYvOHNq?=
 =?utf-8?B?Umg2Mk9HWVUrOFRMeklFMjlKTEc4SXdFcWQ0ZFErVmRDcjBZU0xZU2dSL0V4?=
 =?utf-8?B?dktxWG1jeTlZczRNdHRvNUx4VFhBaVpreENLVnU2eUJyakdNTHpEeDRta2tk?=
 =?utf-8?B?MUxHbjNxNWsvRUFhUDZkVDZMWSszUVl2VkoybWEySlErRkx0K2xwcUhTR3J6?=
 =?utf-8?B?TzhMTS9remRFaHFzaDJKc2NteGdsREJiT285dGYzZVA3NUt0T2x3T2Jpa0JR?=
 =?utf-8?B?b2w2a2hwWHphb0xaeFRJejExNmFVZThsM3VYWVJ6S0NKNXhhNlY2Y3BhQTZ6?=
 =?utf-8?B?UFpPdHE0YndqaTQ2QnF4SzNnSHZKUm1iSS9jWUkydEJLK1lUOXdOVkw4QnYr?=
 =?utf-8?B?VGlINnY2UWFnVS9YTmcxczlwUzVDUktCaXhYeVBpMFRSanp1Skp6ZDdXS2Q2?=
 =?utf-8?B?UDY3R0lUTkU3K0g2K3ZNeFI2QkJmM0FjSlMwWWdLQ3FyS0JVREwxZHF0S3lD?=
 =?utf-8?B?SndRZ3ZzSzAyWWlnSjJaT3U5RXZsZ0x4Zjc5UDlzTmV2Q0FpQXBsS2NWQTdz?=
 =?utf-8?B?Vkh4OXRIa3dZSEUwTHFLcXRNNVYzc292YXhuYURVZGJyNXhxS3NJc0VwRXZr?=
 =?utf-8?B?RDJaYVViUk5Razh3aWpzYTYvdldKRmNZQjlsSGozUXBBQVJuOXpiY1drRXFN?=
 =?utf-8?B?L2ZpMEdMd3FQcGl2cjh0QmRobXVVM29TNGNVNG9qUXpnNlU5Q0t6RUxFQUhz?=
 =?utf-8?B?bHQ3LzZDWEdRcjE5K1dMaG1tRGpyZk9SalJVR1ByNTRoOGg5MkdzSi83Yjll?=
 =?utf-8?Q?K3k9gmalzdsFv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9ObXFiOU8zV0hwUWtIR3RwR1FQZWh0Q1QvRVBIVWpRd3hSOEtjamphK3J6?=
 =?utf-8?B?K3VGY3RaZzRjaVZJVVBqbHRBNDNwVDJpbFFleElpVEJUMXcyQWN0Y3p0MVhu?=
 =?utf-8?B?SzhuSXZvamZ6bnAraWNJdFBmMDdzcXZReTFuY3M3SCtsamxycEJqZkJuQTAz?=
 =?utf-8?B?Mm1FWVhUbWtUZXZ0NTV5cEp0dUxzaktQT0l0NG1JbFBXRmlZcUppR1BlWHZV?=
 =?utf-8?B?bzgwdmwyNEM5TDc3NWV1R0ZURTk0K2hEUU9FbWQ1TVpyVVl1eXFFeTFCNUNj?=
 =?utf-8?B?dEhWZzJSbFkvQmZsRUlrL1YvVmN6UmQ4K0EzUGk4UjduYUtlOEZLUjRUc3RN?=
 =?utf-8?B?MFgyb0x4TWU3akNtS0R1eDhHVDdWclFRbk4xM2IybVZKd2hjMzdqZWJIbVls?=
 =?utf-8?B?RHVFZk04NnY2Y2U3TVZlN0FML2R1WWVaS1N5Y05yaXhHaGxOL3p6Y0R1ekdn?=
 =?utf-8?B?Mld1VGZ2ekRJR1E2bDRrQkRrc0NFMUE1Y25OM25hZzdkT21DS3VUQmNXUE5I?=
 =?utf-8?B?N1JXMlhXY3VkN2s4N2RESU9lTzhNd2p0b2FuWnJ0UWwvN09xNjladEFtS2NW?=
 =?utf-8?B?VGx0RkQ5dFZjOUYvdFRrUGNKMStkL1BudzBlYW0ra3ViS2p0RU8yK2FpNDYv?=
 =?utf-8?B?WXlSMGkvWlNlUEI5cS9hWG9FMUMrTmVCTVhtM2w4Qjl4Z0I5REkzaGhzMEtG?=
 =?utf-8?B?Smt2RU1GVVk3Mmk5dnV2eUdmR1ZVOWR2NHMxdXZaU2RZaUZDNmtYZDZobnhj?=
 =?utf-8?B?d3dxVytwaXhPbll0UzZWOSs1YnVYTmg1VnpkamkzU1Vnd0I1ODBNYXU0U3dK?=
 =?utf-8?B?REZEcVJPbTdLbC9hdW84SVdYSS9Yd2M5WGs4UHhLS0Z2aWhoY3YxSm4rUjB5?=
 =?utf-8?B?K1l1bHFzSVFWSG5xSDBKVGk0UmhiRFpsZG51cC9jYTBxYlVyaytDRXNBWXdk?=
 =?utf-8?B?dHBPMDg0OUIydDhYZ00wZkZuYk43Y0h4N05pdkhSb2hZSm1mQmVFZ216QzJM?=
 =?utf-8?B?bXVNM29NS0lEYUFNQnorWUlxV210SkIxVlhRWXpuN3N2eW5BclQ3ckNZYzE4?=
 =?utf-8?B?b3N1S2FtdFBaVVdDNHA2TjN2aHlERHNHeGRkay9GcVNVNUNiV1llTWI4bDJx?=
 =?utf-8?B?eUluSWdRTEJKUWJDNUw0bDZKK0dTbTlCbmR3NEoxZVJkVWozSUxmL3l5WXJJ?=
 =?utf-8?B?SVlMMFhlaVRhZ1hsUE9Bb1hvQ2lPNnJaQVR5YittUjV1NmVuOFBRNm5wTEFW?=
 =?utf-8?B?KzVQd1NxRXhFQlY2QXI3RHgrN1VlY3Z6MC9udXFTM0owNHpuREgydnY2SUQv?=
 =?utf-8?B?YWcvNzQydHk2dU41Kzl2S0JWKzNnaUlIZytKREt6VUFkSFphZXh6a3puSzFY?=
 =?utf-8?B?UkE0Zm9lQ2dxa3c5bmRraHJISmE5NDJVVVlCWExsSTYvNTA5djB4RDZDZTdj?=
 =?utf-8?B?K29zQTg0WWlTeXRSSk9tTFNGaHM4aWF4eTFvOU9tRmp2Ly9uN1NTTmkrOFlE?=
 =?utf-8?B?V0FCQXFPWFpOcnBSZDRHaGVCemxZZUNPZGo2VjVKUldqcnBBSlY1V1JzM1Bx?=
 =?utf-8?B?NU9OQVpMc2VnWDQzenY3dVkxRGg1Qm51S3RiM1RlamkrOXhsR3dORVdGZmU2?=
 =?utf-8?B?dXVCUWpqemlRSE9iTVowYnZGYUJpOUpVRWs0T0s5YmdvazRmbFNYRHUrekNy?=
 =?utf-8?B?cFZOUG9qZlcxSjFwMVNwQ09MZk54OVpGWk05MlZvaUM4SXVTMmNWLy9Tb0Ro?=
 =?utf-8?B?UXZQYzZUMC9HbFc3Z2oyYjRGZ0ljakVMZXI5OGJpZmVYa0FUOVNVWVhNT3pz?=
 =?utf-8?B?OUpXUzd6TEpOc1FqTm1vZThBQk1lcDRKR0xlck9MQy9KRVJRbEFjTXNXaUo4?=
 =?utf-8?B?dEVYNzhSOVRodW80T2FFaGt6N3FmbHp1Ynhnc29rK0Z3MjJaeG1JOEVqZ05l?=
 =?utf-8?B?enpKWmZXQk5HN2dra2lVVzBsdm53VkU2dGxJbHlkK3pQYmI0WEZSZGU0T1pZ?=
 =?utf-8?B?R2FmYlhScTVqNHNpSjVhTm5TYS9pRGxZYUQzQXRTWDJHdU4wb2JtREVsa2JY?=
 =?utf-8?B?aC95ZGtUL3BETXQ2eWpKcGE3QTZaMkJIbk52RzRXOHNkR2h4SGF3RjRmeXBv?=
 =?utf-8?B?RlQrcUFuUWRJU01EbjBCMmQybm00M2NMdE4rdDkrR3ZpNktLY1dEZDVENjl0?=
 =?utf-8?Q?kTE1OPw/9HBLyuU2H/eAFL4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecca54d-5fa8-46d0-62ef-08dd76d53323
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 19:40:21.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osIIbM+3jH/QogQ9Iavzj/pGNCt6RCFolwtk+AUkfIXyupUB7fTg4Ir40YnLCMmQThS2wOv9XtDtqBGm8l32+rjD+KOvvWNtw+C+sYJFmes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5498

On 2025-04-08 13:41, Liam R. Howlett wrote:
> * Matthew Wilcox <willy@infradead.org> [250408 13:03]:
>> On Tue, Apr 08, 2025 at 09:37:18AM -0700, Christoph Lameter (Ampere) wrote:
>>>> The hierarchical per-CPU counters propagate a sum approximation through
>>>> a binary tree. When reaching the batch size, the carry is propagated
>>>> through a binary tree which consists of log2(nr_cpu_ids) levels. The
>>>> batch size for each level is twice the batch size of the prior level.
>>>
>>> A binary tree? Could we do this N-way? Otherwise the tree will be 8 levels
>>> on a 512 cpu machine. Given the inflation of the number of cpus this
>>> scheme better work up to 8K cpus.
>>
>> I find that a fan-out somewhere between 8 and 16 works well in practice.
>> log16(512) gives a 3 level tree as does a log8 tree.  log16(8192) is a 4
>> level tree whereas log8(8192) is a 5 level tree.  Not a big difference
>> either way.
>>
>> Somebody was trying to persuade me that a new tree type that maintained
>> additional information at each level of the tree to make some operations
>> log(log(N)) would be a better idea than a B-tree that is log(N).  I
>> countered that a wider tree made the argument unsound at any size tree
>> up to 100k.  And we don't tend to have _that_ many objects in a
>> data structure inside the kernel.
> 
> I still maintain vEB trees are super cool, but I am glad we didn't try
> to implement an RCU safe version.
> 
>>
>> ceil(log14(100,000)) = 5
>> ceil(log2(log2(100,000))) = 5
>>
>> at a million, there's actually a gap, 6 vs 5.  But constant factors
>> become a much larger factor than scalability arguments at that point.
> 
> In retrospect, it seems more of a math win than a practical win - and
> only really the O(n) bounds.  Beyond what willy points out, writes
> rippling up the tree should be a concern for most users since it will
> impact the restart of readers and negatively affect the writer speed -
> but probably not here (hot plug?).

This implementation of hierarchical per-cpu counters is lock-free
for increment/decrement *and* for precise/approximate sums.

The increment/decrement use:

- this_cpu_add_return on the fast-path,
- atomic_add_return_relaxed for intermediate levels carry propagation,
- atomic_add for approximate sum updates.

The precise sum iterates on all possible cpus, loading their current
value. The approximate sum simply loads the current value of the
approximate sum.

So I'm unsure about your concern of writers restarting readers, because
this tree does not rely on mutual exclusion between updaters and
readers, nor does it rely on cmpxchg-based retry mechanisms in readers.

I agree with you that updates going all the way up the tree may
negatively affect the updater and approximate sum reader performance due
to bouncing of the counter cache line across CPUs.

> 
> Working in (multiples of) cacheline sized b-tree nodes makes the most
> sense, in my experience.

I'm confused. Can you explain how this recommendation can practically
apply to the hierarchical counters ?

Thanks!

Mathieu

> 
> Thanks,
> Liam
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
