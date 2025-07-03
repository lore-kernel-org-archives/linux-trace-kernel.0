Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2138.outbound.protection.outlook.com [40.107.116.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4432EAD10;
	Thu,  3 Jul 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558380; cv=fail; b=ruBrEn0FfDV4sKzhcnH8+RYkXt9GZ+M1u2mdErSroAytQGlv5IC9q6CVluUYfWjzWqAFjwMvZsXPWn76ijv6ZgOL7gnTTCILANlWiJUNsQd05+KKMPQEr8OFVrj1WPTaqNcUGqAPsbRblBZDN3cEt/xet/J4rxN13IlSVhOcfeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558380; c=relaxed/simple;
	bh=mXsVErYkxH7BUISa4cgiE9wQxyw3ZTz5YVMfQRG9EH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9ybgCEdABOP7Njhp0cTWen9Fqvrlanl8f0FgwynkJE5sP5X+3aAVRi8voS68UHmpF8wicswEO8jKznX4qG0tZ9I2AxdRZt/52w8FcyANE4CHIN3kPT5ZcPnHXJwcAY3uAij7v2WZllP1MmL1smN5KOD+tlQT5zMjdINaK4tlkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sLJwbX0q; arc=fail smtp.client-ip=40.107.116.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sLJwbX0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWmDmi8c+2f/a0OhoBolcwsRf9m/0F/Er713Snz37JR7F4q9H+jXQKS0D67zJVMT9nsXC2OIOgZUXF5RUS+QkQjE72YSiI6/Azhl9E+Tr4C9X4WI7nblgVu5O0NubvmCr6j2WMSbv96gSJ9GxI6TnoVS8nzfofhZ4fasnAwx2potTyka91+fDnDeUyxfsketw5JvxL0GjL8ILP/N7iqolEuYpCPV65L+I+EXcUH9gvq6AIhzcIZHSY0ubcrzaUAV/nW+2tOisabWIpB0UAOEOFLIAbJdu1Pa3Ci7qGIzgDomA5WO4+KHSusQZbR0xdiCz7VYy0Es6uNpT4L1GS2hNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4D/7Kmtp/fs2WHh/b/zreecj1fmYzPuLiH880JX+Jg=;
 b=px3GJ6L4AgzUdzpAY7Eom4m4dMJEePBCls4N5OkJHvvemR8tXa1OPb+enYYWJ+3nklCj1WeQ149dkNOIrJsE4uB31caXajy6j1rknD0LsHXchISsEL5gMlGMclNRWVLh3lL4gKv6G0oFkaeGaPp1p5HkNo7iBt9FXPCElw/ihB+2H27SFjDPlvmafvAcwY3h0v8VykA2s2PYxmIgxsgQCB53d2D/ciV8HAe+NcBZD32Xdsd1P06R5bkNJmzSy83IEHqvedpo+KQ3XOkSkm8thkTtYknKAi1WE4io5MeUXUqiZU7Xhf42IdCTb3/S4lv7+3cEcAfpi/EeTfuDMZ9Z+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4D/7Kmtp/fs2WHh/b/zreecj1fmYzPuLiH880JX+Jg=;
 b=sLJwbX0qzOfadhk1EC04NWzT+WP1phhgcxfk8N5cE1Dz+IlVsnn2N2KKORqabwgXFlaXIvhr7eLJrhah0Y4rChbzbov+J3RU+FPRZTkHXTrltuRo6PEnbubHo3xeuJJmyzTccpz6RbSmptwSI/hscKJdtu5dtThJf2wwxjs31N7fFWPX7ui2bwNG/cGWI5Ept1eKpGKhdlVVVvNDeOGnvs5PIbGTnFNtPAx8m1WqKFoR3WS+bJlLLYgHLSor1x6/soDRG/fHYcdBqrmsLVr1oFRcIL8lCvq8RWpgog5FJ5U23yU6LWJg2XGf5TIGycGards5B9pICU/oFEHxc0P88g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 15:59:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 15:59:31 +0000
Message-ID: <17fd8e7f-eefb-4c85-a086-fa32741c4d94@efficios.com>
Date: Thu, 3 Jul 2025 11:59:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/2] mm: Fix OOM killer inaccuracy on large
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
References: <20250703152032.10507-1-mathieu.desnoyers@efficios.com>
 <20250703152032.10507-3-mathieu.desnoyers@efficios.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250703152032.10507-3-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8592cfca-aaae-4bd2-b360-08ddba4a98ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3pKbUc1dGw2T2JLV0g5bEJwYXRKSndueDNVVCs5SFJ1QllqbFFoajZyVkZG?=
 =?utf-8?B?aS8yQkZ5WmV2ZU9HTGhadDk3WTRTSkVUbjBTRG8rQzAxSDhycklPOCtBcVdL?=
 =?utf-8?B?MEdtM3o2ZkVpOFQrRGMzdFU1WGdYdXFjdDdRWmgvbHRyY0RheGJ2enJhWmNv?=
 =?utf-8?B?T1h1dlhiZ2I0amgybG96dHpPVXNxM3hGR205dHN2SzYwak5kbDNFQ0dSVHRj?=
 =?utf-8?B?ckRDOU5CdHpJUFBMNEdJczg3cGtWbXNZSjIvVC8xWC9ycGFWaVAyYlJLTDc1?=
 =?utf-8?B?V0d4Y3ZvUU5rV3lCMHFQbVF3cmhtMit1OWRjT1liKzJrbE9icVRvcDFTUmx5?=
 =?utf-8?B?L1NRQnU3azZ4NlJXbklCeVRZZUhwK0dGSDdPZVJJaWNmQzNjZVhTeksrU3k0?=
 =?utf-8?B?LzhSZFBQSlJkRDJ2SGtHYnpMRFMwc2Zsb2owZGRtdUNJS2VCOG9QcW9GeXBk?=
 =?utf-8?B?SFpIZDFXQzAxbXk5RmxRU3l6S2ZHYWpMYk82UldQTTVUR21FUG9UelJwMklK?=
 =?utf-8?B?WHpuZUhBOTEwdW1hQXlXVVY1SktUcVJtNHBsQ0Jja0t3UEpjNTBRY29rY2Jy?=
 =?utf-8?B?ME9PR2xjaGgxUE5SMnR2WDUvM2RPWWh6SVRvaHNKMTlUVTJ5elNrUVpjK1Vw?=
 =?utf-8?B?WmV3cVZKWkl5ekZOOWlZcXV3d0I4YW4zQUhYWFY2NmdyaUhLUm93TVUyUk1J?=
 =?utf-8?B?TVQwQlV3eWV0dGlzbkN2MXFNSXF2ZjFZRHcxdU80VnZhOEViNnpIajBWdCtS?=
 =?utf-8?B?YVlIR2xzTXlNRjl3WEdONEtaaGVMT1RNVVIxNTRxSThKdEFLU3BINVJpR1M0?=
 =?utf-8?B?ZlAxOW1VbEgwajR5VE1MbHQwekd5TitwdDE0NkYxTHJTdFJQYTZNb2puNk5X?=
 =?utf-8?B?QWJlcHdXRzRQM01KV3FCdjdHaEZwRnJKdjhZMkFxQzI4UHlrS3RvTHkwcTZD?=
 =?utf-8?B?QW5lSUNxRWVHNGNwK0dkb2s5VjQ1K28yb0sxNFZ3NVE3VUg4ZG9Xb3FiTVg3?=
 =?utf-8?B?Ym96ZEYrR2pNOEZ1d2xtSFd2SXlXYzUwOVNrT3dmUW9xckoxai83RG9CM0Ns?=
 =?utf-8?B?Q01UZWFXUnR1cWkzM2tJeGlub3o0cXd6STFkOHBIRWZsRE85bi9TTGZWWGpu?=
 =?utf-8?B?SXp2S2dSazdDSWQrbnlsV09mRjZHYkJLUjAzdElZa05VQ1pibnBiTk90YU01?=
 =?utf-8?B?WDBrY3JMNmZrUmxBcCtkWlU1eWczRkl2Z1dnTzFWYjFZT043TXQ3MDdSc2JY?=
 =?utf-8?B?ZFRLRktsYnhRYjdIM2VxakJINlBXb0NuRktkamtFYm5aRnNPcmp5YkxXZzBi?=
 =?utf-8?B?V0U2aktqY09xMk5uMUY4WUpoc2ttUjlQYk5TTVl3YUlWMmR5b1hZbll2SDE1?=
 =?utf-8?B?S3d4ZE5IeXdNcVN1bjl0a2g0TGw5WE5ldnJSdlFjU0lhRUprVXR5YjE4b3RO?=
 =?utf-8?B?N2o3eHdKcEw3RlV0ZDlnTFljU1AyOUN0aG5GN203KzRxcWRSRy9Tei9uNnJV?=
 =?utf-8?B?UG0vRjN1dXhxV25JWHBoc0NWY3RpZk9RNDFSaSt6SE9vYmlxS0g4WEdYazFD?=
 =?utf-8?B?NjVvc2FmK0ZlOHdjVW15OTd5NUg2Nmk4NVE0THNqTzRwdDhqd2VDNUFVZ21T?=
 =?utf-8?B?SzMzWTA4YkpuVGozQ3BHV1NFdGx6QmJ2Uk11Ym9rYjNLYW5LZmhiMDBiczY4?=
 =?utf-8?B?QjF4Sm01UWVyVTlLa3NWNnpqWUYzWU5HSndkMHpZTGJ3RjNReTRZWXZ5cVBO?=
 =?utf-8?B?RlVRNEVCdnRaLzBLbnIrditJdzRsU0dqcE9qUDRUTGJXbi81VTdWWVVVbDE3?=
 =?utf-8?Q?CdZs7ZGCIuJNVWVpJuTjSvVO1lmS2Dv0BlHiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dndpTm5DREx0OXUrL25CdXg2d1ZhbFM1QVFuRVNrSjFxSUFyZ1FORjRsMytN?=
 =?utf-8?B?VFhsck14TEE5WWEyd29Ra3JyRGpIOEl4RExreVgwR2Z2STNQZXNrVUExSHdH?=
 =?utf-8?B?dHpXWmcrLzNEdkxGSWhva1I3NFVra3FyTFBnRDQ5STB1Z3BOeHNobVlab1lW?=
 =?utf-8?B?Y1ZpZ2NaVmFpV004ZGU4RmlJYVFMU0RrRDIwZUFJR3RLZCs0eXp0Vk9XTXJx?=
 =?utf-8?B?NGo5N05mSWUzVVo2MzlJN0Y0amxaaGM1VjZSSjJVWkJIU1hOcGFCaWdnQlVE?=
 =?utf-8?B?SEhXUjJVYkR0R3UzRHZaQU8yUDJGUzMrSFFhTXU4TDFGaXVvZm4zZnc3MmhZ?=
 =?utf-8?B?WXdwaXU4UzFJRy9GQmp6bEZsb3BZaEZubUJscXZ6Rmp6cXZ3bStrU1pTQmkw?=
 =?utf-8?B?NmJqT3gyTDVrT3I3OW4wWXhGWk1ISGczMUhhaXRwSHh5MlBvY0FRT203Q2h2?=
 =?utf-8?B?a0ErVzU1dlBpR0R4UGdrQlQxQlpwZFkvNDdqMnFvQm9zVEV5Y3NIOEt6NXVT?=
 =?utf-8?B?YzRUY2lPVjc4cDlPbzJjK21POWxpdDlvZUtlemh5OWhGQUx6b3dCQjZKdWxz?=
 =?utf-8?B?WWhqZEFPZ3ZlN29RbkE1dUpjRk1xNWNPQ290VVhVZDhqMGt4aW5CaXVMTDg5?=
 =?utf-8?B?YXdBOXhZNiswTUtQL0ZCL1FFU0RqYWJKL3BneTBSK3V5SU42NXozVkZ0VUxa?=
 =?utf-8?B?SGNOZzh4TzJaTCtRZmxRTS9lV0ZWN3dsTXNMd2Rzb1EycTV2ZWFCVDgxOS80?=
 =?utf-8?B?bjlEZnh2TkNOQlNOejJUSU9jZ0NkakhuQVYyb0dLNHFqUTVGRVdERjR3SUM2?=
 =?utf-8?B?SjlmUTlOaFBLWGtqdHBKL2JvV2NLRThXZVF5aE5XcU1PR2d3K3BLTFd5SmFx?=
 =?utf-8?B?V080ak53VVhwWVliUGdJM1pKZEtka2JLNVNueXBiNWF2QjZDZGhQWjlpZmVE?=
 =?utf-8?B?UUZlNjVteEQ0UnlXdUZMYis5OHN1WDUyWG5obkpGckt6UzBVc0hEYnB0ek9l?=
 =?utf-8?B?dTQyREdla1dxOVRMZTM4R0N6VGlYV3kxZjRRT2swMGszcXdYM2VFYU9mZSsx?=
 =?utf-8?B?R3FVOWtrbzNUeCtWWlpCL3ZuMHozMnpvblVqQnp0TVBnWFZIT3BJSlVuMWVS?=
 =?utf-8?B?V0h4UEl4a0VVTWpSbzNZYlB5cmkyQy9WNnBRaklwUEFTdnFUMVJiSmZFeStF?=
 =?utf-8?B?bmpxd3p0WUdCZWRmZExFZWpEdXc3dVdVYjdValZ6V0RJK2J0ekFzSTN6YVJ6?=
 =?utf-8?B?ZnFWbVF0UzZzVTRrbVVLOUVKNzVYeTNlMUU3bTIzdS9ZVXg0WWdtQVFhNTZS?=
 =?utf-8?B?NmhMSTF0WUI5Z2c2ZUFabm5XNnpkT2VPbm9yWkZJZnBGYjhCc0dWazBUd2JG?=
 =?utf-8?B?ek0ySzlVQ2ErWnJhQjNkTldjMnRGN1lmZzVNZ3JxNGVMUUZCS3hMRDZtMzR4?=
 =?utf-8?B?eWYzTmNHUENkVUsvM3Baem1nd1lhdk9OeVNwMWNSZXpjT3NLYkFqUDJpeDhK?=
 =?utf-8?B?OU9ST0thOFZwR0ZDZ2FUeHIxVE0za1AxMlJ3WCtOT1p6UnNOTTZvWmVGTjV3?=
 =?utf-8?B?c3BtSE1QUlBFdWdqY09JaURabWw2ODVIQVkyTFMxSUphNkhTYjdaTjV5cnJl?=
 =?utf-8?B?ZTlNV2hmMzZYU1A4TzNWN29leDVyWi92Rm41aERRV0pldTFBVExWNlNsbVZV?=
 =?utf-8?B?eVhlb3VXYWVwU0N1U205TFNWVE16MEV2Q3pMdExzbVNjSTdzQXpiN2VMYmdD?=
 =?utf-8?B?Zmd4RTF4dEZ6M2ZmMzZkejBUd3BLYjRTT1VCcDVPazhJYXRRaHU3S0p0anAy?=
 =?utf-8?B?ZXZKY1dCbERNem9ZM2FJd3I3RmFEdi9nd0Y1MnlzelZHTG1qOGlna3NFSXNj?=
 =?utf-8?B?K0dKVGV0V05SM0xVeTVDcUZ6ZTVtQy81VlFIK3J5M2VSMmZGeGNnSEhvZXpB?=
 =?utf-8?B?dXlUNG9FMDdyeWYxNnZWTlVmRDk2aHdxNFZXU0ZWd0pKU3RxWmFwTzQzUTVW?=
 =?utf-8?B?LzBvMllIU05zbkFERUJWbTJ4aWNnenVzMmRuMnhaemtmWHF4bEdWS1ZFV2F4?=
 =?utf-8?B?WjNpSTlERWhOWk5scXQrU1FtSkZFQWJ5bkdJaW4zemViZlBISlhhZk1LdWFl?=
 =?utf-8?B?REI5V25FU1dySDUzUWNWVHIyVC9JT0dyZVB0d2tJeU9wNWtEbEhMMDNRVEdP?=
 =?utf-8?Q?xAVmulRe54pLtACGJMs1PFo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8592cfca-aaae-4bd2-b360-08ddba4a98ff
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:59:31.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 650oCgsuUKId6zcjF6UneUkIOTEbRk2xyeSTNwmvlS/JtO3LWAyT0+AonHCpw13nMIcrpmjL0Ydb8tUPki6LTayk0KWVXIiDEHvOqt7tCUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6080

On 2025-07-03 11:20, Mathieu Desnoyers wrote:
> Use hierarchical per-cpu counters for rss tracking to fix the per-mm RSS
> tracking which has become too inaccurate for OOM killer purposes on
> large many-core systems.
> 
> The following rss tracking issues were noted by Sweet Tea Dorminy [1],
> which lead to picking wrong tasks as OOM kill target:
> 
>    Recently, several internal services had an RSS usage regression as part of a
>    kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
>    read RSS statistics in a backup watchdog process to monitor and decide if
>    they'd overrun their memory budget. Now, however, a representative service
>    with five threads, expected to use about a hundred MB of memory, on a 250-cpu
>    machine had memory usage tens of megabytes different from the expected amount
>    -- this constituted a significant percentage of inaccuracy, causing the
>    watchdog to act.
> 
>    This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
>    percpu_counter") [1].  Previously, the memory error was bounded by
>    64*nr_threads pages, a very livable megabyte. Now, however, as a result of
>    scheduler decisions moving the threads around the CPUs, the memory error could
>    be as large as a gigabyte.
> 
>    This is a really tremendous inaccuracy for any few-threaded program on a
>    large machine and impedes monitoring significantly. These stat counters are
>    also used to make OOM killing decisions, so this additional inaccuracy could
>    make a big difference in OOM situations -- either resulting in the wrong
>    process being killed, or in less memory being returned from an OOM-kill than
>    expected.
> 
> Here is a (possibly incomplete) list of the prior approaches that were
> used or proposed, along with their downside:
> 
> 1) Per-thread rss tracking: large error on many-thread processes.
> 
> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>     increased system time in make test workloads [1]. Moreover, the
>     inaccuracy increases with O(n^2) with the number of CPUs.
> 
> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>     error is high with systems that have lots of NUMA nodes (32 times
>     the number of NUMA nodes).
> 
> The approach proposed here is to replace this by the hierarchical
> per-cpu counters, which bounds the inaccuracy based on the system
> topology with O(N*logN).
> 
> Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Martin Liu <liumartin@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: christian.koenig@amd.com
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Sweet Tea Dorminy <sweettea@google.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R . Howlett" <Liam.Howlett@Oracle.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-mm@kvack.org
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>   include/linux/mm.h          |  8 ++++----
>   include/linux/mm_types.h    |  4 ++--
>   include/trace/events/kmem.h |  2 +-
>   kernel/fork.c               | 31 +++++++++++++++++++++----------
>   4 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e51dba8398f7..79defe89aefa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2705,28 +2705,28 @@ static inline bool get_user_page_fast_only(unsigned long addr,
>    */
>   static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>   {
> -	return percpu_counter_read_positive(&mm->rss_stat[member]);
> +	return percpu_counter_tree_approximate_sum(&mm->rss_stat[member]);

This should be:

         int v = percpu_counter_tree_approximate_sum(&mm->rss_stat[member]);

         return v > 0 ? v : 0;

To make sure the value returned is positive, as expected by some callers.
Otherwise I get divide by 0 OOPS in task_scan_max after a while.

Thanks,

Mathieu

>   }
>   
>   void mm_trace_rss_stat(struct mm_struct *mm, int member);
>   
>   static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
>   {
> -	percpu_counter_add(&mm->rss_stat[member], value);
> +	percpu_counter_tree_add(&mm->rss_stat[member], value);
>   
>   	mm_trace_rss_stat(mm, member);
>   }
>   
>   static inline void inc_mm_counter(struct mm_struct *mm, int member)
>   {
> -	percpu_counter_inc(&mm->rss_stat[member]);
> +	percpu_counter_tree_add(&mm->rss_stat[member], 1);
>   
>   	mm_trace_rss_stat(mm, member);
>   }
>   
>   static inline void dec_mm_counter(struct mm_struct *mm, int member)
>   {
> -	percpu_counter_dec(&mm->rss_stat[member]);
> +	percpu_counter_tree_add(&mm->rss_stat[member], -1);
>   
>   	mm_trace_rss_stat(mm, member);
>   }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..85b15109106a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -18,7 +18,7 @@
>   #include <linux/page-flags-layout.h>
>   #include <linux/workqueue.h>
>   #include <linux/seqlock.h>
> -#include <linux/percpu_counter.h>
> +#include <linux/percpu_counter_tree.h>
>   #include <linux/types.h>
>   
>   #include <asm/mmu.h>
> @@ -1059,7 +1059,7 @@ struct mm_struct {
>   
>   		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>   
> -		struct percpu_counter rss_stat[NR_MM_COUNTERS];
> +		struct percpu_counter_tree rss_stat[NR_MM_COUNTERS];
>   
>   		struct linux_binfmt *binfmt;
>   
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index f74925a6cf69..d6199b99c771 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -477,7 +477,7 @@ TRACE_EVENT(rss_stat,
>   		__entry->mm_id = mm_ptr_to_hash(mm);
>   		__entry->curr = !!(current->mm == mm);
>   		__entry->member = member;
> -		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
> +		__entry->size = (percpu_counter_tree_approximate_sum(&mm->rss_stat[member])
>   							    << PAGE_SHIFT);
>   	),
>   
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 168681fc4b25..dd458adc5543 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -129,6 +129,11 @@
>    */
>   #define MAX_THREADS FUTEX_TID_MASK
>   
> +/*
> + * Batch size of rss stat approximation
> + */
> +#define RSS_STAT_BATCH_SIZE	32
> +
>   /*
>    * Protected counters by write_lock_irq(&tasklist_lock)
>    */
> @@ -843,11 +848,10 @@ static void check_mm(struct mm_struct *mm)
>   			 "Please make sure 'struct resident_page_types[]' is updated as well");
>   
>   	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		long x = percpu_counter_sum(&mm->rss_stat[i]);
> -
> -		if (unlikely(x))
> -			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
> -				 mm, resident_page_types[i], x);
> +		if (unlikely(percpu_counter_tree_precise_compare_value(&mm->rss_stat[i], 0) != 0))
> +			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%d\n",
> +				 mm, resident_page_types[i],
> +				 percpu_counter_tree_precise_sum(&mm->rss_stat[i]));
>   	}
>   
>   	if (mm_pgtables_bytes(mm))
> @@ -930,6 +934,8 @@ static void cleanup_lazy_tlbs(struct mm_struct *mm)
>    */
>   void __mmdrop(struct mm_struct *mm)
>   {
> +	int i;
> +
>   	BUG_ON(mm == &init_mm);
>   	WARN_ON_ONCE(mm == current->mm);
>   
> @@ -945,8 +951,8 @@ void __mmdrop(struct mm_struct *mm)
>   	put_user_ns(mm->user_ns);
>   	mm_pasid_drop(mm);
>   	mm_destroy_cid(mm);
> -	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
> -
> +	for (i = 0; i < NR_MM_COUNTERS; i++)
> +		percpu_counter_tree_destroy(&mm->rss_stat[i]);
>   	free_mm(mm);
>   }
>   EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1285,6 +1291,8 @@ static void mmap_init_lock(struct mm_struct *mm)
>   static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	struct user_namespace *user_ns)
>   {
> +	int i;
> +
>   	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
>   	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
>   	atomic_set(&mm->mm_users, 1);
> @@ -1332,15 +1340,18 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	if (mm_alloc_cid(mm, p))
>   		goto fail_cid;
>   
> -	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
> -				     NR_MM_COUNTERS))
> -		goto fail_pcpu;
> +	for (i = 0; i < NR_MM_COUNTERS; i++) {
> +		if (percpu_counter_tree_init(&mm->rss_stat[i], RSS_STAT_BATCH_SIZE, GFP_KERNEL_ACCOUNT))
> +			goto fail_pcpu;
> +	}
>   
>   	mm->user_ns = get_user_ns(user_ns);
>   	lru_gen_init_mm(mm);
>   	return mm;
>   
>   fail_pcpu:
> +	for (i--; i >= 0; i--)
> +		percpu_counter_tree_destroy(&mm->rss_stat[i]);
>   	mm_destroy_cid(mm);
>   fail_cid:
>   	destroy_context(mm);


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
