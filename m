Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022107.outbound.protection.outlook.com [40.107.193.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CB2F19BD;
	Thu,  3 Jul 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571900; cv=fail; b=WMfKAmm4NrLbwA+O+HhGJRJF384CyYNIEB5PRd69pFiuEkl75eUd0vBCgu+xJFEv2Ix8cNcH+EpSWw6Em5nUG4zVW0QvEQ9dUnFZD8oSwdj78F4C/Gdc48eg1hfNnAXiKsPCPqlLPBxUml0a2nu7cH9aicrjG4oQoDRhmN+KPw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571900; c=relaxed/simple;
	bh=Rv1Jx05GnQyxOUmAe2jznWRWe5LqxZMJKOAqMpVcU94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ReQyFZAsSepLdJd4iUUtEU6TY0LXr2gsGQPaNPKENoO1mrf1c47y7c3/D55wu5hAwwqWoOdDCcxPwQkD6I/F2xSqjKYKzenaHMVgk3RFdJmPykjyIGCSA6vA+OiYmvQoG4FvNYsjNwpSjX1fismXfi+ncRQX2dJVttozbJ/h0HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XsV5Ay7D; arc=fail smtp.client-ip=40.107.193.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XsV5Ay7D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbM9Ye/iGbTa+E8DWOxmYr5QM8HU8zdeoBZmqIYZZfKoXaSRjuGLXb3hT1k6wLiFo92S7C3Rpt9YrlCmEuaO4R8gHBZ30qjDrKR3XKA4mze5eyXb3afbRKw23qiwOoZld9Tw9RdW+UrXkIUDJTpFok/+sSaLyq50wyXQK1AYmXxcBLJI6g2o7+tF7LXYb0bK70BKSjhSSLU/Io2l4C9vNwvmID6TOpqC6Ylb7O5B5V2U0LqLxHdDxpN3N+DBySlvrn/onP2FyzFjjS9JR+C7kQXgHH0+HVJUqzU5otcskfCfFtkL04LuAcnWBBKFbOasbyChp4N5dP0k2g0diPDSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ftjl/SLcstlSKG3PbQxpkfuJUwbqX4ip5mhyVhV7b0=;
 b=k7Z/bhSrBAQ3p2OzzcVoLipFhJUUSCLxINYpPhKY7c7t/4q7LxuuozuVmNk2rTLmyqDpZk7dnpcczk81tPWBaDmbDps0ETyWQhZSkpMoBtEdkcye0w5zaBOR+AI1dJ0mD97QZwevcxNDRW+x2JVmwXV5isWAUEFiTl0H84Li3xLiqMU2JnICIQQm73LbZzrkTWodYqfCQlgsvbYU2DZ0Fey3FeDqTbus0EjQ5o4bJO9GHUPLg7hMmHN/hkzW83V9Z/vPIb4BI+927PMsYSsW1nWT70ntCb7ns9FNpGn/xbbRrrjsr2GO64OJT+rjQK0MWrm8Z7du8ihsWVDXHGogaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ftjl/SLcstlSKG3PbQxpkfuJUwbqX4ip5mhyVhV7b0=;
 b=XsV5Ay7DFYZDH/EAWEo0MZqYpg2YIR35FTsXAPt9Rljx/OY1eOOujknl2LKL7SrjAwBsbtbYdULiapvmxZcpRdmhJvbiUYlLpbaqtvimhRJS3TaLoRenSwjBDkTpu+vwurLB0TFp9/9X3P9SdfUeEr2gZBRwOGHiqi8M607tSLjFxIm4A3oHkdkutpqbVWYiKj5ug4Roms86iYsOfaqMX/4FCnrYUMOPvSZBy4DP0Wfk8v1Q7sBH7IM4mKQEKVs/OFAQuzs/BqOXs2NGRQOUnRbtMf7TsVh5VqymR8GeGodgMu/ewE17aLNvNOGuy0FDvqrP+g70y7kpKKvcX03TMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9351.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 3 Jul
 2025 19:44:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 19:44:54 +0000
Message-ID: <a6d9f99c-dbf7-4871-a7cd-cdd857bb1951@efficios.com>
Date: Thu, 3 Jul 2025 15:44:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] mm: Fix OOM killer inaccuracy on large
 many-core systems
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy
 <sweettea@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>
References: <20250703173813.18432-1-mathieu.desnoyers@efficios.com>
 <20250703173813.18432-3-mathieu.desnoyers@efficios.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250703173813.18432-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::42) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: afff2643-0f18-414a-5842-08ddba6a1577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTkwSUlaeFkvTUJjaVZxbUVlV1Vic2ZhL05tc3NNYW5zaUR2Tmtuc3hKR0xX?=
 =?utf-8?B?WmpJSGNVeFRObTJiblZWbkp6UENGSTlMV1ljWmZCb1RwcW1MV3psY1VYSTh2?=
 =?utf-8?B?OGVxWlhzTlhnd3VteE96cW8rTE1EenZFLzFodFFNa2NYN1BwaXMyWWg4WVll?=
 =?utf-8?B?dTRFbS9lQmprT1RSWHY3SkRieXpMR3E3TkVMbHJyNzIwbHgrSVMzdWhlZzBX?=
 =?utf-8?B?NUM2cy9JTWdmcmNNSmJzVWpmZXVyTUQrZGhEQjcrOFdyMFhBM1pUVjRPRlZa?=
 =?utf-8?B?QXZwQnBSNy9kSjJiRlhsSXQwcXQrL2gwVkJodSs2cGZYVGlxMndGVndoZVJl?=
 =?utf-8?B?cWxORDcxdnJtK3huZWhXK0dqMUhCMWpweC9UN25qek1XTm53SXNIUlRrNGZl?=
 =?utf-8?B?Y2MxUU5YbjVWRkxxMWdJV0lJcUtJdWtpQWFKeXlvMHBQWXUyb0V5ejkvTVFU?=
 =?utf-8?B?dVNXRW1hWkpjZVROZkNKVDQ2V0w4VGsxYnBIcmt4TFB3NldFR25vQ2pSa0sv?=
 =?utf-8?B?MUYvQzYrWkM0SGtHeCt6N08rMFQxUUtMSnBYTXdYVFQvekdtWk8rZ1pTNkVJ?=
 =?utf-8?B?bHFucGRJMjd0M1lNaVJYTGFDZnZvZU1ZM21JdlkwSEsrSzJOeFo5M2JSOUN0?=
 =?utf-8?B?SnYxTjdrc25SYzNiaE00UVhVcTQxRmFXR2lrYXZGdFF6eldYeTJncnlSaVBZ?=
 =?utf-8?B?VnQxQUdocmdLMnZDamZtMFBTaU9XQWVBS1RuRjY1WWxIODVpSll1bE8wY3JP?=
 =?utf-8?B?QzA0NmJvUnlNOVR3WFFLOVBRYkpFRy8zWWc1Zjl6UXFUSitITmR6bEhkWDhP?=
 =?utf-8?B?bCtVcGYvWEZuZ3lBVGlNTTQyZGJjUm10WVdnVk55YWhwTWNhRXhLcStWQ1pN?=
 =?utf-8?B?WXdsTWtDVCsvRld0Z2pjakJrc2xOOHVmSElvWUk4MlFndW5zaTRhWjlPY0ND?=
 =?utf-8?B?YVZ4bnJaOE9aWURhTmRGeUMrRjNXcXl2NTBLYjZ3REVVM2wvUGM5d0FlRlgx?=
 =?utf-8?B?L0JsWHAvUWpFM0swUmNud1FNRVlpTWRNTlliRnRJOEllSVI1cW4wTnZTVGFV?=
 =?utf-8?B?ckdCTjc1WkRVWi9WZlF4QUo3elhFeGhpNVRkQVV0bFZMdS9WaXplMlpQdDBJ?=
 =?utf-8?B?bmRMQ01uRXBPYUdoVU9rUllsbzJReU96c3BtRTV3K1FGM0NncUQ4NEJWODdH?=
 =?utf-8?B?aFp0UUlZMllEWE9sYVJQV3lZQXovOFBJbG1YenVjWjhFQXM1VFQzQkY5bC9L?=
 =?utf-8?B?Zm5zaU1aUXpEN0FGUjRVeUlYdS9URFdLNlA1NURCdEpNZUd3LzkzdDQ0bStG?=
 =?utf-8?B?WTFUa2tuVU9kQmozZ3hkZ1huZjFJV25UclE1ZlFBT2c4UmxHaGhlVDhUU0t6?=
 =?utf-8?B?cng3ZExYNVJPa0lnb3JCSFh2dVl6RzJBeFFPMWEyLzZ6RGdDVDlGU3MrekY0?=
 =?utf-8?B?Q3dBL1JZdDZ1WHdTZlVNT1Z1eUUwektKaUMrODFhQTcvRWxkQldPZHZQRW0v?=
 =?utf-8?B?cTB6azZMWEhEbEpMVk94UjBEVkpxeXplUXI3WGc1N0FPdWdaWEE0dTFtR1lo?=
 =?utf-8?B?My8wVkpKQWZEWVIyR3IyckVqVDFYUzBLVyt6U3gwQXEyU0pWNTBBYmtRT05C?=
 =?utf-8?B?dWNvSm8xSzczRlA4NVlGelRaaDRYZjFiSzVzcjBWeWZ1ZmVrRjVlUmVIbExv?=
 =?utf-8?B?YVIrMFg3T3pZRkZVODhIMEtuYnNjazAxQjVLWTFMNnE1UnBzSmMxTmtUWU1u?=
 =?utf-8?B?eFF4REhqQ3ZKWS96SnZPUmZNdGxVWFdQRUtCaGpiamlHK2xscGFheUJZNGNn?=
 =?utf-8?Q?wornjVaC/jQaAJw48zDGSHUbjY9nIa5G5mHbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFBQVhSb3FSb1Q1d2tMVnlwWnNrL29QRXVZbXhWd29ocERmM3J4MmR2TlN2?=
 =?utf-8?B?NCtEakJEUElRakIyMXY1Wi92VGJqQURFZTIvUFI1WFN6SDlRYVlRSnlBN1lt?=
 =?utf-8?B?MlBTbDFZeHhBNHJWN3phVHlydnpwUXVZemxhR3JjQjg0dkNTM2RKbi9uRXZ2?=
 =?utf-8?B?WDNuUVMwYThyUERLS0VZTit0ZTRENTdBSkZoRzRvOUVJcWxWNittaS9NR0d2?=
 =?utf-8?B?U1pwby9IdFNiT2lsaFkyLzZSS3d6OFNKMnJpc2M0VzVyQWZydVo4MTRTUHgw?=
 =?utf-8?B?dXlWUzEwTzBCU3RwQUdVcGlUa2RyektXNml0cW1lbzI2b0pPMktQVnZLNjU0?=
 =?utf-8?B?Ylo3SnJRaStKQXE0VDdINjUzZDJSeWtiOXRpOHdJK0c4OHNhMTdNdVhORUZy?=
 =?utf-8?B?VGl5QXdYVEtmK3hoMUZOaWp0eDhrOWczZk1ySmdXRHY4bEFlMkwrdU0wZU80?=
 =?utf-8?B?blQramlBaTcwbVY2YnI2MjlGZXpCbkJ2cmpFbFNRelhINUpYVE1WTDFJZEhS?=
 =?utf-8?B?N0pQUlFad0Z6YS82blI3R2JYT0xlb01wQWVsbit1cmwyQVhPZmhOYXluS2RJ?=
 =?utf-8?B?WjVPYStGMndKUEE4VHplUUNwVzRydGVYdU5qTjdELzNERk9BUDlFakp6Q2tV?=
 =?utf-8?B?cy9VRFZkcXVkVlU2TVN1VldzcjA4MldTTkRCNktoQlE1eUFYeTRGbEh3UHZP?=
 =?utf-8?B?Z1E4MUF6QVArUFA3cWZnSzRubzhYUk9PamJqc1dCUVNQOEV2bUdUTlFHRW03?=
 =?utf-8?B?Uk40clVIODZYNHJpRDVTTTFXcGtkRkV5WEZkSW5HNGpYN0RvRm1CT2V2ZlNC?=
 =?utf-8?B?RmV5K3c3V2RpdmFXYm1xS1Jra1ZiaElmN0xKcU15bnd0WFlGUk9ueld4K0Nz?=
 =?utf-8?B?dE5IK3Rac2FnUlR2R3JjRzdWRnVZeDRqWjhoS29aMEVJbFFlMTBjUC9Bdmht?=
 =?utf-8?B?Yk9ibjIxQkplT3pZcW5YZjFpNXN6UFphUTFoSTFJVDErVHdqNHZLV0RXRjVV?=
 =?utf-8?B?a3lKK3Zjdm1uRzY2Q2NYSWYra0JJN2Uvenp3M1d1enFZZGNSNUFpbnZ4Nnlt?=
 =?utf-8?B?T3FDTTlpV1ZNdTlJMjNRakVjRjNTeG5CT09obDI0TWNrM3NwUTRZN0t2VnYy?=
 =?utf-8?B?cXN1aUVYSCs0L2ZxYVVGMnRNRVo2czdYb3FmVC9JTURjQnMyMEZoZDVHQzZt?=
 =?utf-8?B?Qy8velhWWXFwM0w3MkZXVmZDSVEzNGFMbTdwbU9SNEk4K0ZiNUgrVHYvVGt0?=
 =?utf-8?B?dmlQQnYveTBHUVBNSWRYZ203TENrQVFjYzJmUmpmWmc5RUxwTFc2UHQyNHBZ?=
 =?utf-8?B?d0NjRDVMbTY3ak93c1lOcHkrQjZ6cmZLOTBGa0RCNjZJTnJ5NzFnb2d5NkZZ?=
 =?utf-8?B?ZW16OTVlT3lJOXR6ZnRjZ2ROQU1OM01RR1oxbzY5NW9HWDN2R3hkV2xFVTJ0?=
 =?utf-8?B?a3RTdERYWFZmUFNpYnlsa2ZtNTBrZElZbE5ZVGF6VlJZanZrWSs5Q1pmRzVx?=
 =?utf-8?B?ZG1iR3E4blZtWksyNkxxeVcySEN3N3JOYmV6VG9weXE0aUNmRG5abnBFN0ZE?=
 =?utf-8?B?RUc5bEZqT1lMb3VXdGdwK2RCTExuT0lwbTBxcnphL2ZvZ1ZTVWNjdDV0dmsr?=
 =?utf-8?B?UGQrVmhiOU9wTlpGRnRVQlJYejRxd0pXeG5QNFo0bkZTbmJVOW5qTXRLdFlx?=
 =?utf-8?B?WmZzTzlKeDJVRDExVzdaeHp0RkdXb0c2Tk5KL0lYSVprVkYwb3k4dTROK2pR?=
 =?utf-8?B?ZVFURUZkbENwNHc3Uy9WZS9vMlgrNUQ1RDZqOWE2TkFyV2RGa2ErakFTVE1C?=
 =?utf-8?B?VFFESWgzRkQ4TTIrOHVFT2dFZnRwRVBaOUNJdklydFNUUXFKUk0yeFJOSFpC?=
 =?utf-8?B?VGxCL2ZiYVpxV0k0bWJTYTVVY0U4cVV0ZWNLOC9YcFNMQTBGaTlwS1dDZmE4?=
 =?utf-8?B?RmdpK0pxb1UyNXk3bWh2OVZPS2dtcytld3VYOVE5N2RSK21pQVJ6L1h6REt0?=
 =?utf-8?B?YXJ4ZVFQYUtsRkN0TzUrMGJWc0x1RXREZG1yeDgxMGZqa2xMcGJVWk9TbWlq?=
 =?utf-8?B?cDBrVnEvQ0swU05OTUlmNGVVaEhxU0hUYjZlMk5xbTFZVjFabUxhdmpYSVZa?=
 =?utf-8?B?TmNBTCtRS2pMQ3ZHc1Y0by9rOWN0UmRXMzVpdUZ6dnFoODVUYlNqdlVOcnB2?=
 =?utf-8?Q?YbkG5HULLPyQ3vP4LAVAvbo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afff2643-0f18-414a-5842-08ddba6a1577
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 19:44:54.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5WIf0ejfUx2tM80ZIBCsXmzpPooEupF+Z1N2VWGs6/9OA2VtvCPG9IN6++LiENVyB707wAl36lCJ+2eUKgVMUVe+Vf3jrq8o6x2BkvgvVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9351

On 2025-07-03 13:38, Mathieu Desnoyers wrote:
[...]
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e51dba8398f7..18ccb51dad88 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2705,28 +2705,30 @@ static inline bool get_user_page_fast_only(unsigned long addr,
>    */
>   static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>   {
> -	return percpu_counter_read_positive(&mm->rss_stat[member]);
> +	int v = percpu_counter_tree_approximate_sum(&mm->rss_stat[member]);
> +
> +	return v > 0 ? v : 0;
>   }

In a follow up version, I plan to introduce a new
percpu_counter_tree_approximate_sum_positive() to wrap this
 >= 0 logic.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
