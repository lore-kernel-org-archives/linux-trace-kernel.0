Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795016595;
	b=pE7Vka39xP5hU3dxWr8Ewudb4KzHKdgXahE4tiXhYuPl8dOtQ1+a4JUbGJ+Kq292v712
	 kbNJEB8pitj/92TiUdiQ/fsV5MWOOS1/ppLhrGxRZvLWeBBxyqDoUwvzv5b0Sy+NpKXhn
	 7rUAwtDDrfaAWwVFjly0iz7OyMx/n6njj3qNdv5rXRqZHHoTokeLz5Svy0NKaOb3GbEjh
	 ugZBbbBbGJc74rL0foRWcn7TwsaPkZ+K5UFzM2sMXro8NT9GvAQXlRHJdWdYaAWBTc1K2
	 85WxIaBAMpDEhUqG0TH9JxyFGbRvAQjkrvgML5wiXOmXTb5UE1MlWGeeSncxjDoUi9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016595;
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
	bh=8aZbYHbROIFsEqLCP/MMSfaUrFzmOttHrb5DojZAcMU=;
	b=VywhAVEfTu5hlB23UGcvKjvn9iT6HXmVWdUwkCbEZ+PS+87yOonQFy8mP7AJXCThzDM5
	 hXVORntvwVALbt7p5Z704ikltr14RlFGGNBj7edr9evHCWFPpkqFiyVJ1/SLeEjRP5//z
	 eXIx6TxgNtvbvsEEuffBDliIOtfBthLtTJ+m4tOmg3xxJi/u7jnpfslFzl9Z7jAz+e0h2
	 8xB7KRceqT9s5qEt0ldhHPLPNeYh0UVzwp7F/k5K9lKhmcVURtbEDoPeFiOkCtRhM31PL
	 WqhaM2nXfNAUc1M1Z9JjMJa6Py3odRijmemSBkjpDXSzLPz16+MSGz4yZ1OQlBu4Y+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=SbaH2bQ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.39
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1C60A2607;
	Wed, 18 Nov 2026 15:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF1C60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=SbaH2bQ9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dElLXkI7siaxFRIE+NEbnDF31kTVGnnoTqtb4yb2/NKAinM7bShocCt/UUtPYtoOoxCC1HehEpmlPt4olnDioK7/xPaCqPBzHlbTucduimmNpYvojgMs9P/MHtrL9bSaNgaM+AObCpMjKZAxyzMLWJNZ2xLKwJczOMMhZ+duI5y94U9t9jSUm80OhrcutsgfenlDjHX6sgP9XBAGwwg27sNj8DA5/3tlkDvN9I0w5s4ISLDzJoWOG6VKyf8etH4uI4l446Rb+P2RbpRWvE6+kYD6Vu+Whg+o9W5CGvNnTxl+u/x+KuqugQhxKsdRTh4QHEAeNATkUy3kOVmkVnbapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aZbYHbROIFsEqLCP/MMSfaUrFzmOttHrb5DojZAcMU=;
 b=XoQLcVAn5c4r/cw/Gr3PFDI5NHWOmVLU6nDoLg0JFx5eTBpKSk0a4LD0AbUOUQs6ZqvBFLWXXuQk+61jihDVMJbJipjSteNi0OyzcrTcylxs5UIkF8i+8MPnlu06carpPVPrIukRKGf37DrOOFinr9zBofHAD9XPQLlUr/jolZTGOrXDK/SPtOYI9m25JPup4tB6eULNuP75oNmtle/Rz2kB5NaCHCknEaeFuU06Lmk+H3nWyDOr7GGQ7v+x7re0eBiHJIibLsAD16hWe+sjqeIPrJtWFtKX6Cjp4iDeCjxVheFsyzDjFxXKPrxihW1qCrQuGQfQpSxpUy9c1Lcm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aZbYHbROIFsEqLCP/MMSfaUrFzmOttHrb5DojZAcMU=;
 b=SbaH2bQ9B8fRvAUxV2rWV2Ms/j3YjPcMj+q1Wuf4R7pEBIE8m4WxM3fFlfkcLNz45GAjT/GfUz93mg4jwrXLFU1bExD4OVtkT1eHP5Su32Xf4X8w80ekzW75IrK6qgskaamGDq6ojvPY/UH2J4GMP+wBJTqgK6DbE9qDjTX7FzI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by BESPR09MB825927.eurprd09.prod.outlook.com
 (2603:10a6:b10:129::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:43:10 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:43:10 +0000
Message-ID: <400aae15-aa35-4e49-afa9-427c0fe60309@mobileye.com>
Date: Wed, 18 Nov 2026 17:43:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] riscv: probes: reject probes inside an LR/SC
 sequence
To: =?UTF-8?B?6KKB5pmT5bOw?= <yuanxiaofeng@eswincomputing.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
 Pekka Enberg <penberg@kernel.org>, =?UTF-8?Q?Patrick_St=C3=A4hlin?=
 <me@packi.ch>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Palmer Dabbelt <palmerdabbelt@google.com>, Sashiko <sashiko-bot@kernel.org>,
 Nam Cao <namcao@linutronix.de>
References: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
 <178ccbf1.a40.1a1ee49cebb.Coremail.yuanxiaofeng@eswincomputing.com>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <178ccbf1.a40.1a1ee49cebb.Coremail.yuanxiaofeng@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To ZR6PR09MB889505.eurprd09.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|BESPR09MB825927:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f5da32-9635-4512-42e7-08df458aa5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|261021123027099003|261022075727099003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261026121527099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nqEJA9Y9KL736bgEvZkb6NkJN/Ok6itG94XV5gMV+pi2QdiHB6Z9p8dGb7PuyjFt+dlDTmXW9iOrfa8Z6AzQiwBQhCX7VJBjYrYUSHc3FrP4TqkIVR3fjtWE56TII+KyhfFEtv19AbkI+E63mmH2ll4zv9EObEZy39YxFF0ENNE+s8Ea82dMwZFTF6HdsbZAJ2gN/uMFOvLZ0XWt8g6FbNN15EO3ERhwgjfNAw6mFOu9K/Ygu2p7vYf8hig5Je7+Do064X9gyzkY9MfoXYx3gBhxDIxetUWCqw7jaz9YSOrozu+kScdxiswr+u9dhQbm33Dhx6fLHhZogJvQrxxivV7Uft526j4VlvwxXMtPtvy6D7qD0YjqrrdGxzDXZC/brTMCau5IWLVcRPW9A+ULaqAu3jol05+GKoaUZ/XeTp3YEDTQYN5P3Gq9gvv4MxgiLKEl5ksp+A1lNFHff1qEavwoH99HnZQdvgMK3aIKfyDTMDxDS5Qb3KPvCIa42FEOLWRA/R+nPIpizGJU9ivkDxfSJ8bykF5r5lT+fFR2goHEKMKxm6WLc3xFoR/OqpRAdE9Kr4kz1Ndfg589wTPUzBm5noy3UUdQLPSQxe+h9VPG50xQvfYXYza4WOMBwFW1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(261021123027099003)(261022075727099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qjh1dzdRRVNGNHJTMXRKZ2FJM2lNY2locGlsS0ZubjN0aFhFOGZWdWN3eDJN?=
 =?utf-8?B?Snd4WlBwdnBHRC9HdExDdENSemhQOXk0TGRTd2g0cTZ4dWpWODdXODhmUkx4?=
 =?utf-8?B?bFU3SjRuazhjdDVtUGcxME4rcmw5d0RlMGlEL1FsOGJkQ25SUTF4aDRNYjg0?=
 =?utf-8?B?MEF2Q3lRRmpzNDFwRFdHVzY0cEVsdGRxMVdPNFQ0WnUrdXU5SnlKNS9uWjND?=
 =?utf-8?B?WStHUVg1TjVPTUlyV3lMRElqYTVFeXdGbmsrRUV1Y1ZmOG93UnBpSklGeks3?=
 =?utf-8?B?K3lOZXpMMEpIUDRkTXI4REp4ZGtQSExDK1BuUVRtanN1Q2l6UUJPanJiNTVy?=
 =?utf-8?B?TXZYY3hzMnFTOGMyYnJZU29NZm1vdTVlYktKNlhMVnBtK0dMRlROVXlWN0Jm?=
 =?utf-8?B?VHJTeFJ4TnVhalN0aDdDWVhCMzIwYXMveEUxWHZVa3JVdkR5M1Q4bWt6WHY0?=
 =?utf-8?B?WDFWS0Zsd0E1Ky9SRldKUlFnZDNCRWlEYWFUNTlxbmFmWEZueWY5WStPRnFS?=
 =?utf-8?B?UmxHR0VhZWdZSkZES2tUdWswWElSMWpPMGR3b3ArTWxxNmhsVHExWUhkcTlW?=
 =?utf-8?B?ekpKNDlnWXV2YjBaNEZwemVCeFZwZXBPWkNaeEZmUFAxZWdka21OZFhRZ1Vp?=
 =?utf-8?B?M0R3SDV0TG1zY1dBeWx0dE1TOUFONzVVQy9XblJ2cngycTB4QkRIWTg3OWc5?=
 =?utf-8?B?TEhaMjE4a3h2Q1MzdHNlTU02Yi9RWVJSTDlIangxbFYrSVI1SXpNVURIWldL?=
 =?utf-8?B?ZHdzd2F3aWN6TklPZ3VudUt1VXhRU0trU2ZHbTU3TDFrRzFXenBjQnhicHhI?=
 =?utf-8?B?Q3ErVkNnSWJ3YnlBK1R3Y3VZMW8wdmhNRnh0ZHRXMEp1d29ic2pPbG1xTjFl?=
 =?utf-8?B?SmNkNkVIenJEdnBjWVk3azZoWWNFYzBSNkVPTi9WVUUwT2RNOFV4eHVqN2dm?=
 =?utf-8?B?NWdQU2k5bEIvazVVWnhqWGdCZm1vSkZKZnJoa1JFZm5zak4wUG95dVNQUG8r?=
 =?utf-8?B?aFh2eFJUbEowcEVGZ0c3N1E2SjB6em1iV2JYbko1cFBjRVpWWm9Rd0hDOUl2?=
 =?utf-8?B?QUFyQThUZURVdjJJNHZiZWR3Y3A1N3lGb2M3Q1NmRnZEdXJ6cG9lamhBZ3cy?=
 =?utf-8?B?TmZqczYzelMrVlRwdTVYVUltS3k0SE9ZZmRyY2g0UGJxVEZlYUlySVB4OTYy?=
 =?utf-8?B?UlJZYVV5Wit0cmxXTEU5bVdabXB4eWJCb0t6K1p2ajZLMUU5LytObzBxVUF4?=
 =?utf-8?B?d1huZ1BUaHhMUTREWDRuWXNPcjVUS3ptRk9UNExYcFdyZTN2SGpsdW8vZlIx?=
 =?utf-8?B?b0dPWTBnY0VQUzNVdmZpbWtod21JQTJ5MXUxVXJTZzU1WEVaeU84Wm02V25D?=
 =?utf-8?B?UGVNeHZ4dW0zZEVvUFRQd3dPdFBwNWJHZ05COFNuZXVaUGZ0Z3FyVTBZNEJW?=
 =?utf-8?B?WGZYblNzWmttcTNPeC9UMTlTVS83UnQ2aU51R1ZYSk9VS2NYbzBobWdPbis1?=
 =?utf-8?B?dURMVVFLL1ZVR2FENkR4aENSa1VuS3FkY2FBVlZMN0tIMlFDYmw3V21talVy?=
 =?utf-8?B?REViYkRvczBOS0FHYThGeGJ5a0VkOWlxQmZsL3BQVVBCdkY0ak9rb1NmMWlF?=
 =?utf-8?B?Z1o2TXZIQTNHQ2J1UVA5K2hueXVwd1JvN1B2cnN3NmN6NE9Dd0prSUZyR01s?=
 =?utf-8?B?d2wrSUZRaXhhTWFHU3h3dGxVWDZMRjNtOEFhL2lRYWlXYWJoUkhacXlHZjdK?=
 =?utf-8?B?Skl2V0R2K0o5RW84bVJ1elNwcDgwM1J1RGhhdG9kUmFmNUdkalVKd1lMWU9w?=
 =?utf-8?B?Q1J6ZWFFSUd2MkltL2VXSzd4THgrK2w5bVNnK1FtbDZSOFRETVQ3TzF3dExq?=
 =?utf-8?B?N1ZYUzQ3ZFV3WnBWdUVxdkR0SGxSQnlqVTZMdWJFUUVMVEVYZUFpWXpXaTZU?=
 =?utf-8?B?SEZ6b0tyT2hHTVIxOGI3WEk2dWFtOVJmUVN4aUU3VEM1VDUvTitvK2NtRkM3?=
 =?utf-8?B?b1Ywbkdtc0dTaG8xYUxOZEh0Q01FQ1VNTmJyeDBBSUw3ditkS0Jac3JMdGZ2?=
 =?utf-8?B?bk8ydjVWOGdKNnJwa0hYaCs0YnlUR2FYMm5ReW4vVXliNWsybkZ5ZlpCWjRD?=
 =?utf-8?B?UDdnZWZjN1hlNzA1MkhPZGpCQ3pzZG91NksyTWdUZW01VnRKbGRRajkrVndn?=
 =?utf-8?B?VVlYVFlKU1NyN3lGRldRS0xCckR0Y0dBMzB3cUxNdHR0VGN2emV3bGEwTVAx?=
 =?utf-8?B?QzJLRC9TY0ZXMHA4R1hCM1l0R1JrRXoxLzZ1SjBGNkNmSi9wZ0lOYkl5TnJn?=
 =?utf-8?B?R0pnTkkrWW5GVzFsSWRCa2xqVnJPVFErUWlDT2xjTFVWS0U5algzZz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f5da32-9635-4512-42e7-08df458aa5b4
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:43:09.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k14zity1DKuJK6qWdLQ8MJY+4UU8cZ4Ekk007Iis5/QQjnxH0yzu9AXxv90LwM9J+DRsEJ7AAozo58N+8D4yYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR09MB825927

On 11/18/26 12:52, 袁晓峰 wrote:
> Hi Vladimir, Nam, Masami,

> Vladimir, your forward scan also covers uprobes 
> and does not suffer from the lone-lr false rejection that our window-based check had, 
> so your approach is the better base; I would rather continue the fix on top of
> your series than push ours.


I discovered fundamental flaw in this simple forward scan approach. For
example it can't detect a literal inside the code. In the next version I
implemented a Control Flow Graph analysis.


> 1) Window size
> 
>    Spec 13.3 defines the constrained LR/SC loop as the LR/SC sequence plus
>    the code to retry it, at most 16 instructions in total. That leaves at
>    most 14 instructions between the lr and the sc (fewer once the retry
>    branch is counted). RISCV_LRSC_MAX_BODY=16 is larger than that; could we
>    align the bound with the spec? We had an off-by-one round on this with Nam
>    in our series.

Thanks for this. I misread the spec in a way there's at max 16
instructions between LR and SC, this is wrong. Spec says, reduced quote:

---cut---
The loop comprises only an LR/SC sequence and code to retry the sequence
in the case of failure, and must comprise at most 16 instructions placed
sequentially in memory.



An LR/SC sequence begins with an LR instruction and ends with an SC
instruction. [...]



The code to retry a failing LR/SC sequence can contain backwards jumps
and/or branches to repeat the LR/SC sequence [...]
---cut---

There's 16 instructions limit for the

- LR
- dynamic code between LR/SC
- SC
- code to retry

I will update my defines. I can't analyze "code to retry" and don't know
where is the LR instruction, effectively maintaining 64-byte window to
scan for the SC. Assumption is only valid constrained LR/SC loops are
used, unconstrained LR/SC loops not supported.

>    Three smaller things:
> 
>    - KUNIT_EXPECT_LT(ret, 0) also accepts -EILSEQ (or any other negative
>      error), so it can pass even when the LR/SC rejection did not happen.
>      -EINVAL would pin the specific reason.

Good point.

>    - There is no allow-direction boundary, so a window that is too wide
>      would still pass. A case just outside the (spec-correct) window,
>      expected to be accepted, would pin the bound from both sides.

This is because I can't find LR; this is correct for both kprobes and
uprobes. For uprobes - because I have no symbolic information; for
kprobes - if one put global label inside the function, scan from the
nearest symbol won't work anymore. But assuming every SC belongs to
valid constrained LR/SC loop, I don't need it. This code will not detect
badly formed LR/SC loop.

>    - The max-length case is lr + 16 nops + sc, which is neither a loop nor
>      within the 16-instruction spec bound. A real loop (lr + 13 instructions
>      + sc + retry branch) would test what the spec actually constrains.

Yes, will fix

One more note, I have unanswered question, it can alter part of the
riscv_insn_is_lrsc_body that deals with branches:

https://lore.kernel.org/all/a971d355-a7bd-41a8-83ba-a250e77f78f1@mobileye.com/

Thanks, Vladimir
