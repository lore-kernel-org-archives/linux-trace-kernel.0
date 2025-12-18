Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020110.outbound.protection.outlook.com [52.101.191.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327C22A1E1;
	Thu, 18 Dec 2025 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096293; cv=fail; b=n4iLIDel2WIogcvgqD0sDwASuJ25bdbovnvT+H06mOaAFwS1nvcvqb9TTPBS1a3Md/b8214ElXLiSSEJE2CvlH3IPuo1M6XqMXkqQNsWVsdMSszPu3sOiwFIJROo+h1VqLjer2w5Uf/PgKg8rdL2kFF/HFtUyVy2TLr758odVSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096293; c=relaxed/simple;
	bh=U6Euuum6N+AB1SL0PCiRdy71tWmNFkMtME80iTXLCKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2iUBY0SNYWkQDobou81QKflDSx4O0kTkgusOU982AftdgBImH5oYSZiufMjNRe7GqSnRpqzpwi2rNcArc3p3t5GZxB0W8vvNOmhlA0Udg8YO6ja8LE3JwJjCXO/DvcRzDApldg4urZShaHfoJ0YgwQDMNYFiLlf58hfabO+x5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Xl0/lAl8; arc=fail smtp.client-ip=52.101.191.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Xl0/lAl8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhpCUMHqM7Ss9JeXLvw+PUiSnrNY45DO5aYCCtlnVzaxobsQz6+U9pgwjah6FeOo95w2RfpLsyxlT558ntqEqyw+LT1+gW5N569QUoNPMMvgAwbCZNtWuosEO6X0t+felhAuiuER+c6rTI6VerLpucwKJ6S+amOxQTTbhChMU3j+emQ2uKjrkoeCYEgEGDiN3q/KE/vXiq6N8wR9SJuuxmjTcp3gw0wyf4hBC94P2inISH67P35u46TMSQEdCOY7KC0Tf+AIYk9Qg9a2/aN78tWMayIm3D/aMij2Qp1VN8JrBcWFemxfWZoTsTtkVH30pR/+iARvIvRVHR548SEfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NAMNJPLikpv/Xdck11kJprzNIHQZvXxPbbzh4h/1SM=;
 b=Fi8aS2ddEvsbMzzG05ll/t5ogw/SeYx0SOXg5F6p5zx9VSQzLj6Zw9fbVve4bP2VtNRJnERG0k74RWD/D18XAAg1yke8TDWVoYs9gIWMPGy88kGYBRe6vzmp/SDYKoaFZpGM+ySWntb5+u+7AKMgDhS0gZgic2AjKJ8FY06dpsln9qvN4Nb20kxxt/JurAGYUN2aLiN3WoDOIOnfjcMMBfV3c2PRr29MScr5xdMfkEBH5ddhTzQu6PKxGyrNrPYJVFYi8RPK2VaoF/ZuHLK6+Xq+boxkzqsP1eWUiummOKROqzoDB/4xqpvNSEizR3DZRwa57rel6GxiB+xjYDfYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NAMNJPLikpv/Xdck11kJprzNIHQZvXxPbbzh4h/1SM=;
 b=Xl0/lAl8jvnXyDJMUTcaZKln+8zKLHmBVltw75v1nr0smiqAKQb/1HjnShPUsPon2/0gloMNO374f8xcuREWQB4J1qOHJP3WJJECqf5go4L4vXX6dhLHYqxzb26GsH1vOAfSTBgOFR82qbZtyOzH3CQ7AfdfDmy+Fi68fxjpXw1odI2DN1TQDuBNcx9D61m5JETF/KET/UxYgy9+NX2CD+Vtn8cGM/3lzakfJNrGf1iMbGlCoWEJHvcS3bz3xDzUJBwxlMzru3PViWJmxTphV/7xnp9CLYWmBCYu2jGeO09nGNV/oxmDBQoAfE97lsSuT7yyd6iumsepjedFt9e0Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10631.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 22:18:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 22:18:07 +0000
Message-ID: <72ad1fed-574e-4850-beac-91626e5aaa0e@efficios.com>
Date: Thu, 18 Dec 2025 17:18:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
To: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
 Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
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
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20251213185608.3418096-1-mathieu.desnoyers@efficios.com>
 <20251213185608.3418096-3-mathieu.desnoyers@efficios.com>
 <c8acf650-ef96-4449-ba85-557dedba0ffc@sirena.org.uk>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <c8acf650-ef96-4449-ba85-557dedba0ffc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10631:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7da1dc-bad5-4ef7-f30d-08de3e8351ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnU5RkxWRWZVZnN6QlVQRkJTcVRWVmJ3YS9iNnI5ejFsTFdCSmMvMHNYT0U4?=
 =?utf-8?B?TVZOWTVLNzNKSGVZY01la0NSK1JQekhmTkVNcUFGclpLMFJBSTFCVDFWLzZ5?=
 =?utf-8?B?cFBwMjlHWE1KNndoanczWmt1RGRCb2pUOGlhZkFlTjcxdExVZndYMUd4UERp?=
 =?utf-8?B?U1l4VTNBb2V3QkQzM0tPelJSK2RycEFNbzVlZHdXQUtuUmRpbW5YNHVVRWV1?=
 =?utf-8?B?a3VZdjVmV1NBcDlRbllGUzBJU2pycmxzUys2TWJyeTgzWUVMUkMyR2JYOWJ3?=
 =?utf-8?B?TG9BSy9QOHRlejVUTFhzQ1FlS0lXeURhNCtZNjlKV1lEL3huaGFtNElkU2Q5?=
 =?utf-8?B?cGR4TUI0R2VVTkRwM2JTbE5qVFcxNVB6b2ltSmF2RHlmRFUxS0NkRTVnakZk?=
 =?utf-8?B?d0tzSDJFT2FmYkxMVS9NTkVDNCtGbkptZUhScWk0TFJKNXAzNVVOWlZTV0c0?=
 =?utf-8?B?enlXeGFLVHNUSVF6T1ZleXp6NU81bHRzeGFnazAxQUJENWZyNHFXVWR3S0Zn?=
 =?utf-8?B?MjZMR2ZCMzJwMklac1ZBSVlnMCtYSHBLYVhUbHlJaTMwczlSdm1JMENrSVFR?=
 =?utf-8?B?RkNDWi9YbTBmVW4rZWZucTNBSitIaWMzRTNWWTdKTVZsdTRjcVlneXN6TzV5?=
 =?utf-8?B?VWRRdVlzMXlLcTRtbFJuU0JQUi96Wno5ZHlrVHdzY25HaExieE1WTDdKUGlz?=
 =?utf-8?B?S1J6bWdNV2l0WkEyYk1rWGpXUHhDQmwyNG8wZzdHUWVsRnIyakh0YldGSmNH?=
 =?utf-8?B?UndFTFZtSTY2YTU1YlRMMkUvRnJaVnVmYXZGTnRqWDlXWVk2bTlFR2ZpYWNO?=
 =?utf-8?B?T0RTcU1naTBaMDB1dDFhTEtzeXNTWjBIVmowMWJOdTBDanQ1VmkvQk1LYUR4?=
 =?utf-8?B?bSsyY0ZOblJrWkFLNHFxUVlQU1BRcDdLMlBNSWlXRFlxYnlpREtjQ2JLbnJ5?=
 =?utf-8?B?VEx4UENCOUlwb1crY3ZZYkdzMHdnY3ltYm1ybmdMNnUxTnJoNk1HS0ljYW9O?=
 =?utf-8?B?YktoV0xsdVJTTzZ0Ri9NOWh6V25RbElIblVNVDZsWmFYTHEwak1FdENTQjFJ?=
 =?utf-8?B?dmZ2TUE5V29nd2NjbDQ2VDlJa09CeTJmOWppck40K3lEN25naWdqckRSZUxj?=
 =?utf-8?B?bnB2OUI0RVhnU0cvUGNYOStvTndOOUtWcHRlWGlydCtEOHNTM3FZQ3dnWGpi?=
 =?utf-8?B?Zll1aitTS3VqRDFyTHpOZlhibkE0eEJaOGJUMTZPSjRQMDFzUU4yNDNSVExS?=
 =?utf-8?B?NjJ0NW9WTXlXTnNYcTZRMTFxTEt5dTlmT2xpbk9GM3czaVlJemF3U1BWNFBB?=
 =?utf-8?B?aXdrQzE3cXlvUmR0TmlRU01SNk5Xd0VGaTJuRXZuSFlpaUo5bXlucGF5eTc1?=
 =?utf-8?B?MGhvSGFrZisrNzBybUN6akZycG01ZmVEdWZZbk5lZk84L2NXTlpWNzlSa0JF?=
 =?utf-8?B?Y2wwUmlsYzJmSXptVFNVZXlMb3JjQXBkN25JQ1VxR0x6WURiWUE1SGxWWDVu?=
 =?utf-8?B?M2RqUE92UGw4OXI1ckFNSzlNRXFKWEZZUkd1MW1KWHRSVFVENGpDNnRJNmJu?=
 =?utf-8?B?VVZXUkF6by9QT3lPMjNpYnp1bVhEdXlya3RxWTAxNFRnRHlNNUtGbjVDNFpB?=
 =?utf-8?B?L0NXYnA3U0RzZnBpWEtmeVlPSW4zL1RLQ29BMVJwREg0eDZoOW9uQXUxOTFj?=
 =?utf-8?B?Vjh6Y3VPczRBakdNRXdXbWErOXFpWHF2cW1mSDhZNE1yLzFWaitINUJyaVAr?=
 =?utf-8?B?ZjhvZjR0NmJkc3VKckwzMENMeG5mcnQrQzZqMmY0MlJySUxwMHd6SzZlU1Bj?=
 =?utf-8?B?Ynh2bGYrZGFzMG5PWGRJT3QzUElldFE5QWhvbXFqSGNlMlFmek1DU092Rjhy?=
 =?utf-8?B?U09KdHdCVTA3dnhQcG0rSG81TkdqbUlRQ29sNksya3I0U0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnZyWGdFem40ZDBXMWtTVVlTQ3JPN1ROSktYQi9CQldwbTlHS0lldHZYNWRr?=
 =?utf-8?B?TmRMR0dzR3JJRktGM3lrOFBGWTZTK0xmNVZYSzUybWxJbHpZQUJYbUw3NWpv?=
 =?utf-8?B?Q0VuU1AvQWRGd0tIbTkyVjB6dVFUNEJadjY0UCtlbEJLeFBSZ1JoYmgvaWNo?=
 =?utf-8?B?OWRHSjk3d2lPQUd3cDMyWUpKQXFiMWtOL2NBQ0ZQYWNzZ0NXZkw3MjhZc3dD?=
 =?utf-8?B?NVpEaHFWQ0t4T2hBbmY3ZDZJQlp4Z1ZQNmlzVTFWU1ZSQmZJTFVyNkdCVng0?=
 =?utf-8?B?cWlGaEpLNksvTEkvVUVMTERVQlZMTnNoSSt2azZIWlExL3ljYmQ1SmMvNnNs?=
 =?utf-8?B?R0tJbGtnWVFnbjREbWJiYzYwcnAxVkt4YXNTY21XWldhZHZ6WWl5QW1wTFVq?=
 =?utf-8?B?LzBTWFJaTlF1RjhjeGhqL05wbi9mWUlOdytNY0ljbVVRVHhYV25TQnAybUdM?=
 =?utf-8?B?K0wyYUo4K3Fwbk9mdXZKeGl4azhRbnNJQjVGYU1BMGQ2MTdsd0doVnpFMzNy?=
 =?utf-8?B?NWoyRThDYWlIbm1hOWhyZ2kzbzRMYTJBUXVaQWZzTDByT05zUlJpeGpndjd1?=
 =?utf-8?B?K3JMY0lBR2RidldZYWRUQkdLYThDS1FSdXBTWG5EVlhSbW4zbTUvR2ZIU2Nj?=
 =?utf-8?B?NzRsUW1tOVVHeTZNWWhIczNuTlJ1ZGRjSi9JU3dJSUJWcTF6MUZOcFp5dnFB?=
 =?utf-8?B?S3VNNmpnQndhMFc1Zis2a3d6bVA3VnozNmg0YWtsS0pFeXorMEltT0krb0lX?=
 =?utf-8?B?ZjFUUFFyWWFBdUxnREx4eVRZZ2RCQXJsTkJrMjEwVm1pNVJsQjN5MnhEeEQy?=
 =?utf-8?B?RWVsRE9xVFNVYndhMEc3YnFZOTQvWHY2Y0NNZWFBRmxrMHUzTWcwVm9Kb0Zp?=
 =?utf-8?B?Q1lJYzhaSVdNRU5oczBNN0tEMUpLU2hKTm9oUXI3MlZtUGpseVZJZDZoaENs?=
 =?utf-8?B?NDFaYVRsVTNXcjBvQnBSVFJlYWd3N1RRb1ZlVk05cmg2QjlrQkVPT1lmRU9v?=
 =?utf-8?B?TUdjeDFkamN5Z0V1K1djdjRpVlBzUnFiZUM3UnkxRnlROVp2dDJScVhjaTNZ?=
 =?utf-8?B?cnFzOUNQc1ZWdGVDY01pb3ZnZTBKdW42UnBTYkVla0xaVmFkQ2VrTGxKdzNz?=
 =?utf-8?B?T2s4dytyNnJCUGhnT0NpdHhxSmV4Z29rYnY5ZzlqdHVEb3hKaWs0OXRDQjcy?=
 =?utf-8?B?NzEyTkw4TGxVMnJhWlZXMFUvTHpUTm5mTGtqYjRsMU1lbVNaL1JNZk1hREZn?=
 =?utf-8?B?eUFUNXhvaG9yRlU4UmNhVlV3ZHpPWGlEU2VRQWtLVHY1S1J3RXJSUlNNTWtP?=
 =?utf-8?B?ZU13MzV2TFdqek05MFpXUFBmeDVEUVFTV0dpRmh4U2tGMkg1TFhSZE9zcXpj?=
 =?utf-8?B?WkoxNnc5RUpqWE82MjVXNFYzUG4yZjl3eWZhVjAvdER1aC83UkNVTlZXSUpw?=
 =?utf-8?B?a2tKQzd2RzlTQm83L0JDd1N5dFhWNE41Y25YNmo2bzBWV3B3Z2FBWWY5bTZF?=
 =?utf-8?B?amNqL3RaNGNhMjIvQlVjVTFldUVjQjAzUk5yeEFYQjVvQWFrWng2eDNlRWo2?=
 =?utf-8?B?S1JiY3ltNG8rRmdueEI0bzV0YnJQbmRNMFc0WDgyUXVidEFIMFV4dHZERWRy?=
 =?utf-8?B?MlVsdFdic0FCNWZrRzFNcXVVcGFEVjNSaG5FNUYxbEFiRytUenlSSlJUZlF6?=
 =?utf-8?B?dnVGNG4xLzF6anNRSFNrUWw2N0JSU2FDMTI3RjR0NGdvOXFEM1ArQWxyekxW?=
 =?utf-8?B?VithOUlyRHRaOEZRRzZkaGFYcG82ZGtXa2tGYmhWbUNXbWs3SzQrdDNMUzJL?=
 =?utf-8?B?QU8rci9vTHN4bmNDMGxjazV1Ry9QYlRFMmJpUW56aXE2ZnUvZVo5cTBqVndY?=
 =?utf-8?B?VllBZWFtbnE0QVR4Q1U4QmVZU0VtN25tdTJzNkRGUkdlR0EyZVBaYUkrWDVh?=
 =?utf-8?B?VUkzYnBZSXdyT0xuUFp4V1MrbUZrUEpVZDN0VE92dkhZZlVCdWNNZEp5dURQ?=
 =?utf-8?B?bysvbkxLaTV1MnVEOEJFcm1GNVRWMkM4S0dWVmtMMDdCQ2dJT2dmQjZKdTJK?=
 =?utf-8?B?QWNGRm84cjRXY1hwSyt6OS82anEvOTdGajlFQmlTZzZpdVBiYVVoYjg5dnBI?=
 =?utf-8?B?cnlNdzkxeHo3Y1Y5UmtNUnZmYWc3dTk3Nm9hUVYvWmtZZzlmUG1mcGZsSkto?=
 =?utf-8?Q?LSDM7j2dS3sokK2cmLBmb1k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7da1dc-bad5-4ef7-f30d-08de3e8351ef
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:18:07.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OcHqR+jOHQBS/axYhWl6rQxgKUZv8uRrmP0q3CX4JP09yc22nNzR826ICN3B2HUFtfg+FPqiOQQlut4jn3qkFxWwXNKD/SnjRfR9B42TZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10631

On 2025-12-18 13:00, Mark Brown wrote:
> On Sat, Dec 13, 2025 at 01:56:07PM -0500, Mathieu Desnoyers wrote:
> 
>> Use hierarchical per-cpu counters for rss tracking to fix the per-mm RSS
>> tracking which has become too inaccurate for OOM killer purposes on
>> large many-core systems.
> 
> We're seeing boot time crashes in -next on the Arm FVP and Ampere Altra
> which bisect to this patch which is commit 240587b6cca2822d.  Many other
> platforms aren't showing this, though we do have some other breakage in
> -next which might be obscuring things.  We get a NULL dereference:
> 
> [    2.481143] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> 
> ...
> 
> [    2.485036] Call trace:
> [    2.485094]  acct_account_cputime+0x40/0xa4 (P)
> [    2.485226]  irqtime_account_process_tick+0x17c/0x1d8
> [    2.485382]  account_process_tick+0x12c/0x148
> [    2.485531]  update_process_times+0x28/0xdc
> [    2.485656]  tick_nohz_handler+0xbc/0x1bc
> [    2.485809]  __hrtimer_run_queues+0x130/0x184
> 
> I note that __acct_update_integrals is being called from here most
> likely inline and doing get_mm_rss().  That uses get_mm_counter() which
> we've updated in this patch, though I didn't spot the specific issue
> yet.
> 
There is something fishy in mm/init-mm.c:init_mm. The initialization
of

        .cpu_bitmap     = CPU_BITS_NONE,

Keeps room for a NR_CPUs cpumask in that structure, but does not take
into account the new extra room needed for mm_cid and the hierarchical
per-cpu counters:

in mm_cache_init() we have:

        mm_size = sizeof(struct mm_struct) + cpumask_size() + mm_cid_size() + get_rss_stat_items_size();

So AFAIU we should extend this end-of-mm size to include room for
mm_cid_size() (2 * cpumask_size), which would be an upstream bug,
and now room for get_rss_stat_items_size() (which is an issue specific
to -next due to hierarchical per-cpu counters).

An ugly work-around that may work (and then we can improve on this),
at the end of mm/init-mm.c:init_mm (completely untested):

        .cpu_bitmap     = { [0 ... ((3*BITS_TO_LONGS(NR_CPUS))-1 + ((69905 * NR_MM_COUNTERS * 64) / BYTES_PER_LONG))] = 0UL },

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
