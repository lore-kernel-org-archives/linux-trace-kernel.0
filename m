Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D5283FEE;
	Tue, 11 Nov 2025 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838806; cv=fail; b=qwDccsmbM1D8BqZO76DAlTqhpjVw3cM8rkym9b6++srP6eeJUJGK14rsEnf+VeSfCvhgHVP3AT2dP8cuLCrsLHV2WmrT2qNYVqox+1W95pdSi6wW3aNXA//aAI3CQMK+++CzCeFsPK5B8l380Yw3KZkEBXRTthRzkWVpZUOBkrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838806; c=relaxed/simple;
	bh=nOAVkYpvO99yed6C7ZFj8nvahoKrzo3ourGH+1E8MZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g3AsQ70og9UIatlYj36/uUEA/Weu+S86WL2YOBjvwYGCoJSGgn5s9TGfYbl+H6N4he/xW0rLprbL+x42JTqSm9dxtRCvwuESUyLhj2LvCIS2SbGkNO+OtAaewXtGfcnwiAr84YXO8uqdJ24XzH74KlfpiOymwHuU4rdvykw05zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XW7To1mm; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XW7To1mm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW0FqUMPGGvI3c9DQ24YzKlr086yaPsRCbceV5uOGwE0TUEosyWGoS//RkgxDNA5QyGvrIzVTjOuohKEh+GHrAFcaIugw/fNXgofQGI00iefPk7fuFEKQcCLGJKGQkdkxoiXIg0dziVnsLJ81LHeLoigiW4GNSVbWJ7/TFPuqUkSEe4y5NrijEaE5wP00SyGsiEYfTwiNjcryBWxBRYDPv4cHXCUvqV6xyS4Lrjhv4bhoe6JtHv3jUai69VY2x5H7EVQRfgsb66GSjR/b5I/Oebqht+QvzeABytwGDzQdojzwbnuxHyTtZc2ALj6oRzbtjGmzqPQ1A1VjtDBHvaW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8neRj2Q7t1HNQ5sv7vGiQwQar4UrwBmrxFUIw485epE=;
 b=Tvr26sQEUszVIXgxYSfK4FqoBph578+bWd1x+6jGiT8Gb+xUI3OqGRugvXczGOl/ij0XEwXp+ASy5p0fSOA9dIEXwANcNU8Q3F/fIbhpXs30FdAm6pCQ46mRLJB5SGx87B7AIHZqFOEhYxH+7Dx04JCg3F+YopfLj9xsEgog3u7vAWtduAnq4EL0EJPHibYVYiBfwcpjrDTtZSBBlTGH+1O7m1XKuGhOwyNJaX7TRKWuorbedvn0AxeIbMdn+gGQUIXLIbUIWVnn1QKkA6+91d/JTb4PqYm4iORqw2WBXIhiKzLhcln0pTJvxkHiHqzZR2FNiB4f7Ua91D+0ap8ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8neRj2Q7t1HNQ5sv7vGiQwQar4UrwBmrxFUIw485epE=;
 b=XW7To1mm90wgwx1UDYnv9K1Ncty5RexmaF2hk7b2cnKg0hdaLfxSOPWDyrWpgIupnsHjoJr/H5ltOk7L2gHjv5PYtGaBSLNezP9pe69u0N80PkBltuFTesSwiPjmnaCIBirHLlVxxT6Y+GQOCSThVRFrJRpyNV8wt259qYpm8Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 05:26:41 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:26:41 +0000
Message-ID: <eb30616a-efb4-42a4-b7ed-899578922cfb@amd.com>
Date: Tue, 11 Nov 2025 10:56:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <f21b37bb-7a2b-412b-be76-e8968b4c375d@lucifer.local>
 <3b10d11a-3c75-4c37-8810-e238113ce75d@amd.com>
 <bc07aa10-d8d1-435f-9393-6c4ab63cc179@lucifer.local>
 <e9a0ec60-6e8c-474f-931e-2f97e5bb60c0@lucifer.local>
 <69FF5A7F-1414-4DE5-8A2D-09ECE240711C@nvidia.com>
 <77925a0b-fa06-4200-a967-a66bd93201db@amd.com>
 <27920b64-240d-40f6-a02a-0a8c433ca9e1@lucifer.local>
 <ec53bd13-42ce-46d5-a1b8-c4157663b60d@lucifer.local>
 <b12340fa-358a-4799-a040-636994beef36@lucifer.local>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <b12340fa-358a-4799-a040-636994beef36@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e06dc8-b5da-47e5-cc1a-08de20e2e4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enJNYUgvVUQ5djk3cld1OTd4bEhsQTYwa3RvMjBjSHA5dWxwL0tCVm9RQ21a?=
 =?utf-8?B?OElvNDllaTNuVlBRYW83Mm9Oa3cySVQ0RUtUWkkwbnlJY0xhUzJqcG5PQmc0?=
 =?utf-8?B?VUEzL1FxQnVhSW1BMFgxN1g4R2krM2I3Y0dMSkVGVXBCSmJiM0ozdGRFd1ZQ?=
 =?utf-8?B?VmZrbnI5VHdmWnowMVFkcks5dFFwclRmTFNkUHYvY0VObXJ6TktwR1NoWGx3?=
 =?utf-8?B?TU1wNHo3N3h2U0U2bWdyUlZFWklJNVg2OGdXcDdQNFVGc3Nid1grVnFEbitv?=
 =?utf-8?B?Skw2TWFXcm4wWlRlZGlZcGhUSTJBcThhM0lLWE1oMXJicXRHbzBSVUp1MnZM?=
 =?utf-8?B?cE9jMDVUdVl2a1lFaHE1WDFoYmFCdys2RnFvdklJZllaNVVacDEzby82L1ZU?=
 =?utf-8?B?Ukhhc1UvUzR1Q2xiRDlvWnlZb2pYcE91OG9udkFZYkRzRVh5eWl2enhFWGFw?=
 =?utf-8?B?N0NyUmZVSUo5emk0MCtxeEdjV1ZmWVA3Z1NMMXM2d0hwcC9ZMERUa1Z1NnhN?=
 =?utf-8?B?d3BXcVBDMkhhL2t3aWtGTnNQRWorSGxUeDhGYVEyZ0NFZHZ3Q3pLTXVWN3Vj?=
 =?utf-8?B?YXFrbFhXSEVySFRSdHQxMGhmeFRYZW1XRG9Vb01LVWNOakVoWjF6RXJlYmY5?=
 =?utf-8?B?SDQzcTB3czVYY25MUnllQWtURUtod2N6YjVtTmxCYjJjSm1SMnNTdVVncVho?=
 =?utf-8?B?Y0ZwSk9ad205b0grcTZTdWhRdm1IN3JnbEc0dGx6VUVDWnBwN1dNVGIxN3lG?=
 =?utf-8?B?WlBIZzJFRXpQcmVSbkw0Vnd4LzlpbGNrTGFaWU9JR1J4RHlLOTNKUVhabVpB?=
 =?utf-8?B?QUZDREYvRXBmWjdCbFVoYUtrTmhNdTk5NllqdWxVK0tuMXRnVGJtQU4wQ1BM?=
 =?utf-8?B?UXZGOCtyVVBNd0tqYStqZVZnOXRmRUo2TDlRYk5JbGlOWkFqMThuYjlRZXo3?=
 =?utf-8?B?RFpHQWFqK1lyOS9VYVgyRC8vOHV5YjE4T2txZVVOdXJXVDVpdEJVcHBWZmcv?=
 =?utf-8?B?ZkE5TDhGc1pUU0tYRjhjRkJ2ZWx6andKT3lPSmtucUJIU0YvaFg1Zm4wdjNr?=
 =?utf-8?B?NytpUHVYeHFiM3lldEhNc0poUWRlM0t1RmNiMXE0QzUzNEFSY0ZNdWRQNXB6?=
 =?utf-8?B?ZDNOUmJwVDV2WjYydW9mK3lTdjdHcXU4TVJSc1FjdFM1dVJ3SWxKL2gvNTh6?=
 =?utf-8?B?SUF1bFphaG1nZ1JORUZ6dGVMZnV4d2ZqeTBxL3hpNnZXbkhJQjhvR3krdCtZ?=
 =?utf-8?B?TWkyNmxnT2hkMXNpWUdhQVdXeXpWTVpKV2xXdmQzWmNvZnN4aDVEY3Jwb0kv?=
 =?utf-8?B?QklKMW1OZElyaHorMFhXVytVWjJtSk8rajFkaUZreWQxQXFRdHYvSWg0MGdy?=
 =?utf-8?B?T2w0S0ZYMVZwcUNMeitmckh4Y1B6amxNdHQ4bmNMZW1xQnlxNG04REVUSzFV?=
 =?utf-8?B?cTBZcGFNSFo1UFRLQm9BVENOS2hiaDhVNFlSdFFQaU51U3lMSXJTV1Q5b1Iv?=
 =?utf-8?B?RmJkUEFscUIrVkhieDFmeFJKbVd1T0dNQnZMeGVONGl2cUVmOW0xK0dCZHpm?=
 =?utf-8?B?bEtVZVBYMEgwNkpiT3pNWlVDd3puYUNrSy8wZllQQlpLajR6TlhIS085NXUv?=
 =?utf-8?B?ZFh6a3JUZE1rUnpITFZ3cVJ4V0NJaFNJSEo2bHVFU0xTUjV6UElaNGZDRDBi?=
 =?utf-8?B?MUNFUlNoZnpZL1hxK1d2MjkzT1FieE1oMHhvblBkbHhOVWw3QjBpWTFwUlli?=
 =?utf-8?B?QUQzSlMwSW1rYUM3Y1ZPV2NqUGtRclR5MElWQ25TM2RSQ1NtQ3laNmRhU3dh?=
 =?utf-8?B?SFE0SktTRkRBem5DZ2tJa1NNTlNrUDB2MlQ1NEpTbXlOam44ZzZJU0J6WmJQ?=
 =?utf-8?B?aWMwR3VjdDRxczZqeVRnWFZWKzQ4TlhiSlFsQ242WDhCRHQ0Z2tjS2VkSEw3?=
 =?utf-8?Q?JOTAdaSAnJG1JCMgvOEUUyF07jdoWjVr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGRRTXN1RUo3WGJQQkI0L3VldlB5d1FLWU5VTkQrL2d6K3Z3NnNhV3dPN2dv?=
 =?utf-8?B?MW5TZTduRGlEUzVaSnlDSlY3OWxFVHpjL1NTUkVEWHA0dWYzcEYxSloyWVJr?=
 =?utf-8?B?UTZOZnBGbms1V0g4OFRMMWZqbmlDcFIxZ2ZFWnByUitWWWdJYWtHNCtxZlpx?=
 =?utf-8?B?Q3ZwaHA5NXAwaGZZWkVGb3RrbFhFZnYvZHBURDMwaFRsdkxyNGttc3Z5KzRN?=
 =?utf-8?B?aEY1S3FWazhCeVRabmJvREZadEZGeHliWStUQ1IzM0YvYjhyeHBsb1owQTQy?=
 =?utf-8?B?LzhneWx5VXV3c1hjcU1DN0tGcG4vUkZyY2llVmhuM1NCSHRJd1pXaXBBakdP?=
 =?utf-8?B?YmpsWEJJREtKNE1NYU4zMkozN1VjZ0FvbU5od1UySFRSU3BkNy9JdWFIaGVm?=
 =?utf-8?B?bmxSTTBjTWxQQXZ3akR3d3ZDdmNMeW5tS3Jnd0lGSjRnamJxMVNFbDlubnJ0?=
 =?utf-8?B?V2NxRlJ5cE5WeGpxa2UzKzZXQkJHaGdCNkRRejZrRkNvdkx1WG1pbDlJMHUz?=
 =?utf-8?B?bkJrUCtWUURRMUE3SjFVNmtTTkJoSWhHQmJ0N21pWktPbXgraTdSUmdhU25S?=
 =?utf-8?B?NWdHY0JTSTR5SDZjVnFOeGkwRVh2V2pZaldxR0U5aWpPYXdUdi9ETlVPMzlM?=
 =?utf-8?B?SFBrWkRzN2NEZTNzNTVyVzZsd1hpSkVuS2hoaXhmRW9kdnlDaEs3Vk9ITVdo?=
 =?utf-8?B?QTg3Z004T0VmUU9QQUFyU21ZeFN0ZFNtZTI0TjR0L1ZneTdGei9YUzY0V1p5?=
 =?utf-8?B?cENzUmlqaExHRFFQdFNVN0RQdzkyU3VBSzRtS1dDNmNTcVY1OHM0UndkQ1Fi?=
 =?utf-8?B?UHFFNVJYZnMyNENzb2RFdGdyYjZFc0dodkprYUs0Smt1aUY0N1RRd0RNSTl6?=
 =?utf-8?B?SGx0aUpJKzhiUzJ5RGJ4VUxjMkkvbk1iSWt6OHBIdHZFOGliSnI0cjhoaDVJ?=
 =?utf-8?B?TGJTbGZJc0lmTWxnbDJ6LzVZcTJLUHptcUxTWG9DSXI4WlZuRzNTUDc3d3du?=
 =?utf-8?B?ek9vd2k0dDVyT2hRMCtKNFlCSHZoNDdCZEVRNjFYVFpnZ1RmeTVzTHdNdTk3?=
 =?utf-8?B?RHJVNWlVaERQWmt3NFhwbFAyS25rZUZwY1ZsdXcxRHdVcWp1SUlWWUJIdSt0?=
 =?utf-8?B?SkhJNFVTZldSbVFpVTlEU0QxZlVObUI0VlpXQ1hJMFdhdUlwbUFOcHZPQzQ2?=
 =?utf-8?B?ODRYYWdWWVhudEw5amZZK05VbTJCZ1RIaXo2K3dNdDB5ck5tclJXMkd3MUp5?=
 =?utf-8?B?Um9WRENmMVVGdlhISy85eTFrQUJQOTVEU0VlYU9BbkZ2ZHlmWllKODBxUzQ5?=
 =?utf-8?B?Y295dlFxc1dtSGRsKzV5cTlNOTllOUwvNFhsNWlBYXpHcDRZU0ltZkY3VDVN?=
 =?utf-8?B?ZDNtTXJvc1hzZEE1YzEvOTJPbG1BQUpYbUxFWGNmTUdjRmR4cUU5TmhWQU56?=
 =?utf-8?B?TFpuL09TWmh6N2MrbzYvV3NieDMzQ1grTDU5L0NHTW9pUE9BbHp2c3Iwb2h3?=
 =?utf-8?B?NGdLalRJNUhuem1GU0NtcmlKaGV4c2dwR2FadFdicmEvY2Y2bitIZlRScGht?=
 =?utf-8?B?YzFhWEpUTktsdFVWZ1RMWDBvSTEvWUNWVDFaUHdEc09hblArY3ZwZVhXazlD?=
 =?utf-8?B?MkwwRDNFM2M0dGMxV0dvNXI1ZFhHL3BaYkpHUHlBcnhXbnZaZncwZkpXaG95?=
 =?utf-8?B?Nmc4UHR5a01aRDh1Ykd1UUt0bTh0LzQ2cWtrNUJQWXJsVjVFRXdlT0U4dnI2?=
 =?utf-8?B?M2pHVWo5cmhBUXRQVEltOFEraEw2T0dGaXg2OE5zenpFMzlYc2JFdlZWMXpw?=
 =?utf-8?B?d2hFM0xXR3hxRHJ3OGpWMkw2dHhadktYM3piZjloV1gyS3lMWktsSS9EOWdP?=
 =?utf-8?B?cmNDUCtRZGZ5VjFhMGpMK2x3Z3BRYURiNHBaL3hpR0s4dnRDUmE5V1ZhVHl5?=
 =?utf-8?B?Q1hDb3lPMTMxSDFKRWxReUFya2k0aTYvQ1hLVFhvcFQrbXd1WVZQNmYyRmJK?=
 =?utf-8?B?TjJYeUhGY1dWd2l6aGEwQk5VSy9BS3hrY2JzbStmbnVYdlZJZDJlb0I2aWxS?=
 =?utf-8?B?aXhLaXpkNkxNNHpVQ3ZiUVk0Z1ByN2E5RmR1anZ6aDVPVi9MaFdvc3hSY3FO?=
 =?utf-8?Q?jz4FCX6uo7QcYAPuxHA9Y43ki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e06dc8-b5da-47e5-cc1a-08de20e2e4ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:26:40.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dpotn0KFdhdfNqMnCV57GmSwBsPZv34yIuRSstb/ehXsM08ms9rW8IXdM5JukMtGBWMXX0MVkcIKF+OA8k/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325



On 11/11/2025 2:46 AM, Lorenzo Stoakes wrote:
> OK ignore the past mail, I have managed to repro this locally and have a
> fix.
> 
> Turns out the swap code is doing something quite insane... I will send
> fix-patches to the series shortly.
> 
> Meanwhile I attach fix-patch! :)
> 
> Cheers, Lorenzo
> 
> ----8<----
> From c705fd85a806f53017df31e6b072c4bfa839e3a2 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Mon, 10 Nov 2025 21:11:52 +0000
> Subject: [PATCH] fix
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/leafops.h |  4 ++--
>  mm/swapfile.c           | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/leafops.h b/include/linux/leafops.h
> index a464a7e08c76..c4cd36760ea0 100644
> --- a/include/linux/leafops.h
> +++ b/include/linux/leafops.h
> @@ -56,7 +56,7 @@ static inline softleaf_t softleaf_from_pte(pte_t pte)
>  {
>  	softleaf_t arch_entry;
> 
> -	if (pte_present(pte))
> +	if (pte_present(pte) || pte_none(pte))
>  		return softleaf_mk_none();
> 
>  	pte = pte_swp_clear_flags(pte);
> @@ -95,7 +95,7 @@ static inline softleaf_t softleaf_from_pmd(pmd_t pmd)
>  {
>  	softleaf_t arch_entry;
> 
> -	if (pmd_present(pmd))
> +	if (pmd_present(pmd) || pmd_none(pmd))
>  		return softleaf_mk_none();
> 
>  	if (pmd_swp_soft_dirty(pmd))
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index fd23d9f7ae10..f0dcf261f652 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3202,9 +3202,17 @@ static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
>   */
>  unsigned long generic_max_swapfile_size(void)
>  {
> -	const softleaf_t entry = swp_entry(0, ~0UL);
> +	softleaf_t entry = swp_entry(0, ~0UL);
> +	const pte_t pte = softleaf_to_pte(entry);
> 
> -	return swp_offset(softleaf_from_pte(softleaf_to_pte(entry))) + 1;
> +	/*
> +	* Since the PTE can be an invalid swap entry (i.e. the none PTE), we do
> +	* this manually.
> +	*/
> +	entry = __pte_to_swp_entry(pte);
> +	entry = swp_entry(__swp_type(entry), __swp_offset(entry));
> +
> +	return swp_offset(entry) + 1;
>  }
> 
>  /* Can be overridden by an architecture for additional checks. */
> --
> 2.51.0

The fix works as expected.
The issue no longer reproduces on mm-new.

Thanks,
Shivank
