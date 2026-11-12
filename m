Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482382;
	b=EFd8j/auNvjGoJFK/kmzC6F087yGyJVmUo/GWhzkU446pI5UDRJZM1esQwpSYO1BR/cD
	 UkvvdYZeiC85jlY3wOoWrJ+znZrnU7Jp0h4/ob2cEC3UHT6ElKRLdmIuRniNUtWkqVno1
	 w8j5blTCbXu+DF7nEQTqZ5ugDFTa4snX8bQF12TI5tGfHYUVFmX93VMbZVIF1FIFVPx7A
	 qLZpNV5iwIqPoJt6iKCgQs8ku/7D4gaGJzGCxP4M9JXcLeWSa2fXhzCb0era53G7wuw6s
	 a1Ek/Iag/sxYQSn9zYt8mVPxVepmEy52/B90AYAJvfWIbYNPqbwCrGk8juccPKOMtqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482382;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=yVMgmOBDB5ZBXUP0UJcWoZXjXDNDT+AmBzVWYkic3qo=;
	b=cK7yL/OudMjAx8bLsH5pcRubjinNtIFl0W/sD/7Xl1tR5+Z53mNf7pdBHhiZWfbihx7C
	 my3q8D5G4EcLVLSyyvLhM//y9l+N2NEQoorWPOgyGe7Ypj9VvSEK815XmqX+OKUATYYn6
	 XKv6Y9fEgd313U6F3OMldOX4sfQdGo0HLzIJ80+5F1LhXCnwhN20PlkwfM5qfsZzFWvil
	 NaBNKbl+nWfY/mdF1Lk9h5buYnLkhpAdie7ON02JgVjwlKwY6Ih6tg/0xqOk8jlaoYJTC
	 GlO/0QpKelSArtgUXjQOzCwsfEUHvesVKuhNJp7hY/kmlJ5162Wj4K6Mf0paXG0F1Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=IaWYoIHX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.46
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D471606A323;
	Thu, 12 Nov 2026 11:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D471606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=IaWYoIHX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwipydxFiCK8ENfz8+84cm58DyFvMeLpZdFNyeNBIA3UA6csotD9KoZTBMy4h1mkcwOSyUnSBmusDI7VvMxrMRFOjBojXNuEdYnk0IMU2Ia8WMGMexBl90NN/ya6ESb0x/XslJ+Plr8CMS9xeR9dQ/y/AkGbZ4fTXYQCqNazCgJesJQo1bywqh3uP1bbKVXX/1kocoHC5ihzlG25i3C0NRKZtrgS/YRu27zQ+l1YkpHd1It37wxhVCd3Z+wAYNLY7AWLrLrELCje4bz6eT/ZiB5cQ+pBxsfcEw8NPglu9LYECz+PEx6nePOmFXa3BGeZABnmSHL5TzvGjUghjg/M9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVMgmOBDB5ZBXUP0UJcWoZXjXDNDT+AmBzVWYkic3qo=;
 b=G7VccYehEDjc+RcerYbG3gVS54BEHFEi2Eckfl3RKv3jGAUgU9+jYPoRuwOmpZuHB+j7hqcrB5n3GmyIsUU3RjmYuGIKOFYKRdLUKuef9dbD3HRM20BNilaURRdLGXVuvoSD2AZ05xGAVFwUYXQzfrtG49MKtqaXLOJtEnYkNINJ6TflrT0kSy5ip2QU9hMNEPKF9n8q0khhkKMkwf5ggQgeqP8cfeknWmWn4a1Jgne3whHno7ZO8raH1U6JZb1eTflF23ENCUbrb8i30RzViG6PX1DcxdJUBKlYIWFRbAnsBBX3TQzHCUcYywcj7rDjoHONiSQvAMsFZ0mOaN4U+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVMgmOBDB5ZBXUP0UJcWoZXjXDNDT+AmBzVWYkic3qo=;
 b=IaWYoIHXAzOf4TloX7bSRoAkNoHzkGa9fpm2vBMofpmssatlq/Bok9NdvDyc/IXeguXt5Pp7N8HiO1qPKVBCGptdc5iTjULE7LQPq2iULaSSWDIldoC6CtlB9rWHvGouoaVUQFbLODyjmpHRJYnqgN0Zc3plK7ZhyTazt9L6YSY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by AMBPR09MB8820.eurprd09.prod.outlook.com
 (2603:10a6:20b:77a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 11:19:37 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 11:19:36 +0000
Message-ID: <6990d868-73ef-4d72-97f1-8fcc592e2c0b@mobileye.com>
Date: Thu, 12 Nov 2026 13:19:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: probes: reject probes inside an LR/SC
 sequence
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
 <20261111-probes-in-lrsc-v2-2-b2525b7e1e8e@mobileye.com>
 <87jymicwmu.fsf@yellow.woof>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <87jymicwmu.fsf@yellow.woof>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
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
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|AMBPR09MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d50df5-7d36-4d14-2801-08df40aed5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|4143699003|56012099006|22082099003|18002099003|11063799006|10067099003|261009223027099003|3023799007|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	3C1Y+X/6tai3fgcQ+yMbXtI7cbwtYWZTxvHb8xSmCsGj/SzzhEJ8QTkSyC73fPVLiOKJ+m55sDZ+RQprDy87fr2CxlUVx+ioKmKpLQUwj/qbpYqdUdBEIb41ZdM1gP9ehbPgAuOmWA1ugvY8L3Wi0ecvazCti47EmFTNiERi8MfTstDK2ICRtFu0kuTOcr259KZnTL0gNovNJJRttZe/sb1WiTH42MHn/mJGD75njmOjUzu8CgutQvVYowakICcgLWrAcp28h7qq/EiK+za6jmezSJnt9ljzyq+y3tv5nminGbSg+tXGKzFxTsS09zETkwErvt3KXRPsy+kQfO929tWK6HgXuPSNpIB7Q0OHmj1++S1dPljdOCe/AcMC98RNL9pN/gxUYG09IHG4/ADb9bXTqeOH80rZWAIqsA4cNLcGzalbs4vdBAeTOxks0PwHBJgP5qZyXZgNtnlgbohcFZrHOelP5b5QdIHnhjdhPeT3uqR+B4kJdMHRJOZY//N7/+Wo31/6y9nB6J0utV1zDvGH+Y8CQLShfRGVmIuPBqzNFqFvRUCWplsbhOK4ZNWA4HH6uCuBUWxBk6lL6rvBP0aiRA36xoa56qreqeN3ZdoPABgfAVl9rqjgo8Z5xtBs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(3023799007)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJZNTAyR0tQZkJmMS9IS1l5TVJ3YWJBZTVub0VQTHc1RmdtSlV3RG5reksz?=
 =?utf-8?B?cFkyU2l1aUk0dC8xYlVlcEhtQVBpZXdxM0FOaktlWTdWTFFKajUxSVpMZktX?=
 =?utf-8?B?N1dlbjAxeURLOUxSTGhRL21CTkVpQlZxZmsvalEvN0NuWWZUZFRXQTBlanVL?=
 =?utf-8?B?ZnFBdlJlYkhkd3B3by9UUFJIVThlZ2F2dXczY3dQeGJhdG4wYmtJdFJZSmFh?=
 =?utf-8?B?dENHMC8wQ1czNjJmZFlqL2R2L2FmTU9wMmFvc1NsZDB3a2JGN3pCWi9BL0Zu?=
 =?utf-8?B?Y2ozWWpETkhNbGZwa0ZaQkpCK0YzQk53dWkvYXppYkhObDlicFRwbjdZdmw4?=
 =?utf-8?B?K1o2SEpZK3hsS2orYVg0Y3ZEZnJ3YXJUdWdqb2FaWlluNThvZVY4NFRFd2dm?=
 =?utf-8?B?eSs3R2dsQlVkeG50ZHptdjlsVHl4UTFaMWx2andIb0hhNzUyK3ljOC80ckF3?=
 =?utf-8?B?c3BsQWpsSjFjc3hWZzVRYkkram5lYk53V1J1Um5jM1RWV2ZRN2FEcjVGMUxY?=
 =?utf-8?B?OVQ2TzgrSlpuT0JlN0VKY0UvOUlGVC9mbnAvZUcySGlVWnpwSHlCdHZ5R3VO?=
 =?utf-8?B?cFV2aDduK3JlY3ZyS29ZeE5aNCtVU0V4a0ZpdjlqWDNKNGViTkUwRUw4bVRE?=
 =?utf-8?B?d0hBUmFmK2VwZGMyOEF0ZGJ4aW9RYW9WZ0w4djNlVkdRY3dtZ2F1RVFGdmlE?=
 =?utf-8?B?aU5RYWE1VW1TZDVNNHJIU3JnY2U2cG5SRW11RWpQdndvUU1veE1ZM29SYnc1?=
 =?utf-8?B?alZzb3hsaVpyRXprWmYrb3NqVDFFeGx0VnczbXpjWVI5ZGRCam1MZ2t6VGs3?=
 =?utf-8?B?WFRIWGxqdGhuUzZHR2xWSGQ4c2NiVHgrOWFrUHlGUHJzQjFQdzlPK281ZjZa?=
 =?utf-8?B?UVVsK2VKd0VqeGJLNHA4YzR1bmlWdXdWM2N3b2Vkbm5qMTZleDd4dW5KR2NH?=
 =?utf-8?B?SytUMUtSbURvUTg5ZjVwWWdGaXU4UmVoNkNpM2NsMUZVYVFmV1Ztd3FSdTI4?=
 =?utf-8?B?Wkw5ZnM4M1htR1I4aU9OWDVlaFk3MnBnSzVGb0g0V0dreHpXSk1Fd3l0dkVn?=
 =?utf-8?B?ZXhKUm4ybFFmTVNqLzNjREtIcmxHa2lXR2grWEY2aTBxWFNmRU0reDg4Y0w1?=
 =?utf-8?B?ZDcydUErbENtVVFmSkdKOE5GRzc2Zmg1S24xYStPNFE4M3VLTm1vUThvbXR3?=
 =?utf-8?B?cDBGekQreUxjcEZKMnhxSXYraUdxdEpwZWhHVnJ5OGZyeGNyamEwb2duUGpo?=
 =?utf-8?B?bjhVS1FJTUIzN1IwN2ZoSlBZQzVqOCtaZWZmemxncE5RM1Ava3AwSmpCVXBK?=
 =?utf-8?B?dEM3MDRNUWhLdE5wYmhhVlc1elRWbDdLVWlTTUZGc3N3Tmp2dDBOYk1pWGRo?=
 =?utf-8?B?VEppdEluSmdqTlpqTk90YyttckpGVWtWK1lrdjM4OWc1K1dWR3F0SVZJNm1U?=
 =?utf-8?B?VHNJeDEvZ3BDU0ljb0w5YmcydDMyWURiUzhKazNSY2hDb1dOWTRjUlZaZ1hw?=
 =?utf-8?B?WHZQdFViWGFHT3pQSjJXUWhDbmxqUDlreHVQVVdubEFoaGtWQkR6bjlJdHJs?=
 =?utf-8?B?dVJEVStoM1RYZ0ROb3A1MWdvaXZxOVFIKzN0aENEajE1RzVnUmF4blhzTi9j?=
 =?utf-8?B?T0ltYWQ1Mlo4VWV6eHlMZVYvN1V5czBwczBicWxUVi85WkVrQWVDc3J2WEYz?=
 =?utf-8?B?VFp0alhPNlo0M0ZJOUJSUHFOK3d3MmZOTWVxMDNRNHUzbWFPcUJyRlpQT3NF?=
 =?utf-8?B?Zk5wcVY1R1NZc1BndGdRU0t1TWd0bHJzWUFVekVHbGdXdVdOSTlQMmNqaU8x?=
 =?utf-8?B?OHlZMFBIWTVvT3dCdjc2UEZ6TjRLM1VuSVA3SjdiYjZZQVdXSmJNeElMNEpD?=
 =?utf-8?B?dzY1ZVNqS1N3bnN6L0U2akFjQm5YSGxpdUFIUE11dnF2R01qdVJ6ZHoxcm43?=
 =?utf-8?B?eVlieDZVQWdIVjV6MVVnREV4d09vdklPbzI0bDlheStOMXhDYVFEU2RNd2ZT?=
 =?utf-8?B?SVZPQ0JvU0NQcG5NeVdhd0hjdENXdUZJLzVxaWREUnZvSkJYQ3FCQ0RPZWVq?=
 =?utf-8?B?UjI4OW1PenNJalFZcW4zOVpkeVYyMFIzTmhpYU1FWThzSXdYYnl5alltUkdI?=
 =?utf-8?B?YWVrRGQ5a2cwemlIUU5jWkhuanNaam1uQTdNWWRJZEo5UXlUbUdTZjdxQjh4?=
 =?utf-8?B?TjdhcjJrNHE4Z2V1Yit2NWhEaDFuM05jVlVQbTBqOXcwKzZEZ0NPM1E0c0U3?=
 =?utf-8?B?czRjWjRvTGpxUmNEdFlxcFhmS0lGTklGVlFwZHkydzRNQ292c21TanNHQkZW?=
 =?utf-8?B?MVVKSjBmQ1pWR1hmZGhnQUhURVR4UHAzaVc0bzR3WDFXa1ZUTzlqUT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d50df5-7d36-4d14-2801-08df40aed5c0
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:19:36.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09AOUCtch9c42h3/N96ZdAvtyqtHXcYNhBy7glo54+9K7eRQVkObyxCGI+874SMGNVnHf1evV9i1uH54qxuS5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR09MB8820

On 11/12/26 09:54, Nam Cao wrote:
> EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.
> 
> Vladimir Kondratiev <vladimir.kondratiev@mobileye.com> writes:
>> A kprobe or uprobe replaces an instruction with a breakpoint. The trap
>> clears the hart's reservation, so if the breakpoint sits on the lr, on
>> the sc, or on any instruction between them, the sc fails, the loop
>> branches back to the lr and the probe fires again. The sequence never
>> completes.
> 
> Xiaofeng sent a series addressing the same issue:
> https://lore.kernel.org/linux-riscv/20261019134121.1763-1-yuanxiaofeng@eswincomputing.com/#t
> 
> I have only skimmed this patch, but this patch has an important
> difference: riscv_probe_in_lrsc_body(), while the other series
> implements a kunit.
> 
> Perhaps you two should join forces?
> 
> Nam
> 
Ups, I have already sent v3.

To my understanding of the risc-v spec, one can't put a breakpoint
within a valid constrained LR/SC sequence. However if lr is not part of
such a sequence, there;s no restrictions

I'd be glad if someone can comment on this because this is the core
point. All the text below assumes this is a correct interpretation of
the spec.

Within the lr/sc loop, probe shall be rejected at positions from lr to
sc inclusive; but if lr is not bounded to sc, there's no restrictions.
Good example would be __cmpwait() where lr is followed by wrs.nto, in
this function probe can be placed everywhere, including lr itself.

As a result, one can't detect lr/sc loop by searching for preceding lr;
it should instead search for the following sc.

Xiaofeng's patch interprets this different, it searches for lr between
nearest symbol and probe position.

Difference best seen in KUnit test. See this case:

SYM_FUNC_START(test_kprobes_lrsc_gap)
.Llrsc_gap_lr:
	lr.w t0, 0(x0)
	.rept 13
	nop
	.endr
.Llrsc_gap_pos15:
	nop
.Llrsc_gap_pos16:
	nop
	ret
SYM_FUNC_END(test_kprobes_lrsc_gap)

In this fragment, in my understanding, location .Llrsc_gap_pos15 should
be allowed because it is not inside a valid constrained LR/SC sequence
while Xiaofeng's patch would reject it.

Xiaofeng: let's join the forces, See my patch addressing the same issue
here:
https://patch.msgid.link/20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com

If we agree on the risc-v spec interpretation, let's stick with my patch
for the [ku]probes itself; and adopt your KUnit stuff for the testing?

Thanks, Vladimir

