Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831201F8BD6;
	Fri, 11 Apr 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397205; cv=fail; b=K+Ad9wfiD4wDWkR52xr8lkFuO06iiI0RwUeJXdSOE5gJT7gz54W89In07fpo6dIdrvi8kU5ZSyiUdo5iz/zJFjjQA5f0W6M4KpSfmB4vmDKDfCHvcRR48UAbc/qNk8oouCW8m4p+XWZm4D/73/fbKjzL0WxEy3TFqSF5g8tJcZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397205; c=relaxed/simple;
	bh=TsholNuLxgrzbvYjQJfh8AWrbi7PrC7lnxQG6T8vSMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tQ1LXo5Ej96+z//9B0lpr9d8MRFobd3j8RTGHks4/17DHlabYxZ8kQ+jgS89JLBrmFmOr0Fk9H0j0I1F2ZSURcQLS0XNo5JTdDGEly7ANaBIGyU2GwY947NSG8f+RFnu7zCXCP8D2qcLwpEfnyTH6NdzlPrRB3ZzrkyXaURzFFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=kApss7xd; arc=fail smtp.client-ip=205.220.177.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="kApss7xd"
Received: from pps.filterd (m0316043.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9P9SM020996;
	Fri, 11 Apr 2025 12:41:42 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 45wxr8yp1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 12:41:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyWIPtJquwHoWDJf0nMuJl4LuU5CBBHdZse7q2GnnRsCmZPHO/XiT1EcDjVOS/OTrMIG7IgyhkCbTScQ4/RYYW4NbF9sNO9QvkyZBD9bR62JEWRAkSdv2njmH1h78opG7hfN8SlH176kRGEghsJRmXIYWGQfSvYM0yCVfZBc1kHGkhpXdOMf25yp0r+erH3ePSEduFBOzlGf5pvw8vN0oNEPXymGRfgIJyqe6wPveK9RlmMowzHl3r/nGTejBn4AXUe/qDHxNmKnavCa/xZG81x9CKrxyju+YB7KxGbYlg/nrvHeGH9O+jNRR+qsTqhtQ4cpLiLtoVQfQaWaelpK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGS9UiPLCjxvLfSG3Z82sOoNBp0NimG/Bq53dgiI290=;
 b=oKs+mBNXZo1RZrbDf45PLOpiZBebz6yepy2kLTXpRqAa/rrTA5aakizddpWUh7w6J0w8OXJbP/xu5SM/bAccyEEkzFGazpLDg/mYu0+OC3Z87xolQIHfSYJd7XX2oM1R6EUlCnvMw4kQv2nAkgxJTBhYNh05NV+WTG5u5uGiEfIMNNkHlUekUrz7xQ1xun3gQiRClmmLKHooB7MPRq1jX2iPp5zb080Jjcc/wZYdTWv1okal2C8N5vy92TsYMyTlPp61YT92SWMysrP6+rqWN3WUU8LjKMJ4g5rWEPj10uLhEXiH78bNsAtuLPMBzwY/Z+tE2sp2EUDHgnAXllFkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGS9UiPLCjxvLfSG3Z82sOoNBp0NimG/Bq53dgiI290=;
 b=kApss7xd1PYsd3wAUaz10T+AtPZPc9oZCpvhdYeVIxNRxyWUwdSAbIjahjxTJLU0Wgq9FKb1duMT1VIMFF8XXxu56UamXi8CKPCkj3ayxrjYPD9RW2LbCAj2+kLgfXWgj1R6DsChClH8Xzx0aBMmwk/6kwUEHAPhcepfBx3zACMS53CXvkSzpIHK+xR3ZDFyFsLLMZKm/cdpFgQvdxHozu2jD+ywvI+bKtEmWDwWKx3tkws9WU4wUW1rDFFB+Ox2gDf0nKt3pDfgFguImS0J7Ce+aEfmYHf9q0JQiU15SiHoq0z2XuylJsDW+LbqnjTnVaa6DR8rDVqgVXZhNR0MjQ==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by SA1PR06MB8199.namprd06.prod.outlook.com (2603:10b6:806:1de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 17:41:40 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:41:40 +0000
Message-ID: <4a90f134-82ac-428e-be5b-916cf031157e@cs.wisc.edu>
Date: Fri, 11 Apr 2025 12:41:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Interface for enabling context tracking
To: Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
 <a9d1144e-0f75-4594-b85f-d66b1de623a0@paulmck-laptop>
 <20250410153244.6b20e328@gandalf.local.home>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <20250410153244.6b20e328@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|SA1PR06MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: cc72d21e-6fac-4c40-df2b-08dd79201d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|41320700013|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHh3V1ZHRlVubXI1MVFpanJTQUdrc2lBblF6Mi9BUFJzaU1Ia0ZPa2JlU1ZH?=
 =?utf-8?B?bFRyK0Q2YURPRWU3SFh5b3FEY0ZHc2dFQithdDAxbENzM3krYlRlRkZHM3B6?=
 =?utf-8?B?WndVVHFmK01leXhGUFM0U3kyRitKSTBMYVd0K1RJMUVFQWd3dlA4R29yblN5?=
 =?utf-8?B?TU9aS2R1TDFaN3lvRjk3blNOandhMTFxbmlURWFsL2JIYmJHdTZvaUQ4dEdZ?=
 =?utf-8?B?dXpJdEhRZXpSQVBFZkFSNHFYNFZ3NG55OEdpeGN2OG5zOUxRMHl4blErZzZj?=
 =?utf-8?B?YmwwQWpmT3FXUG9XeHlsb045T1VzTGx1RmgxbnU1Y1BoU0pGZ2srK1YyL2FI?=
 =?utf-8?B?YjJOK1VQS0pCNVVHQ2Y3cHYrdUQ3SHZvNTNRVitOZDdCdVBYakFxVmtaMlA5?=
 =?utf-8?B?SWZVT3R2TEhkRGUrUXFzWmlzTmc0OU1Uc00wK3B3aGI0Y1huZ2VEOW1pRkhl?=
 =?utf-8?B?WlJHdERid0FDd2k5V1RETEU4K3J4NVQrS3RoSU5uWVFiRHJUVnl1L0xBRnl6?=
 =?utf-8?B?ZFJHZUF3VnZIN0djUkNYRHZ1eGdzV2Q0dVZWUEs5NkVMT2Z4WDBHRmdZQmNW?=
 =?utf-8?B?a0lyYUNpd0ZQbnNGeVhwc0ZsVHdhTUVQV3pZUU56a3lJYmdLZlBCclp6aUFp?=
 =?utf-8?B?TUt4ZjEweURBcUMzOHI3ZkNqbklLTDVnTG1veFA1OUplMm1EeWlTWkVJQksz?=
 =?utf-8?B?dVlhWFdMZkJleGZXWHIvOWo2TmdkK25Ldmhpc3hUVGpLM1FpYlVyVlAwNFVO?=
 =?utf-8?B?Vzk0azdPTENWSExWUXBlRXUzNGJ5eFB6RitYV3hsVjIzS2RnQjYzTlZ6RG5F?=
 =?utf-8?B?VzRRU1ZBaWZvSXI2ZXZDeXh5VzBSTWY5N0ljdk40SnM3REVrMWlFelc5N3V4?=
 =?utf-8?B?VkQ5QXgvcXF6RTByS0x1dnFUNFBJeVE0YStSZVVZV3B0SENXa3M5MEk0T2VU?=
 =?utf-8?B?TFZUeEh6OUlNWVBOQTQ0b1RSVjY1eVg0cHJlT1c5Tmp3RFRVOGZPKzRQbHUv?=
 =?utf-8?B?NXU5bGhyeE0zVlh2ejZpQ3BnRUZOL2xIdmYrTlordmh2TlRFM2FkbDNNaHo4?=
 =?utf-8?B?UzV2QXhjS3Iya1FncUdjVVo4b1VyYXVqM0VJZTZ5cUl3ZitlcEhraEtKVUdV?=
 =?utf-8?B?K1l1Um44TjdHczE2MHNPcmVYWFNkS0V1dmdGWFlLMGJnWHQ1NU5QMCs0Snpw?=
 =?utf-8?B?OHVEN2laOSt2dDNQUnFqbXIwY01EanliK1ZFR2owcTVLL2JvSFQ0Y0tWRjRs?=
 =?utf-8?B?N2NLSDUxcHVUQW1DcmtSL1ZhSkUxT1FQcFgwMld0OVEzbjloOExPbmFJZEMr?=
 =?utf-8?B?NUhYRklScXMxcTR2SU91VmllY21GSjFYMEl4emZhQ0piT2pHU2ZGb1dONTRD?=
 =?utf-8?B?aElGWWMxNTlvQlhHb1VpLzJZV0tIUmZ4dmZiRnhVdDZSZ2pOUUlrejdTTjVi?=
 =?utf-8?B?bmFIc2FlWDg5WitRQkhxNGQ1UmIxR055akMyYVRBRTBlMEJqdDhQOEw5S2Nk?=
 =?utf-8?B?N0o4cW1GbnR0eUxaWC9iTVIwRjBHTDhWcG43eXNrak5sQ2hkU0J0WjdYVy9V?=
 =?utf-8?B?NG5XeU9PUGxWTnA4VVlXb0h0cHNiY0VzYU9kOE5uckVxMDdFZ29EUEZiUHNx?=
 =?utf-8?B?RkFXUnkxV3N1M1V6enF5aTY4cjFQd25xaUkwK1BnWW1laFBRUlVkNW5Tb3JW?=
 =?utf-8?B?dFdLbUw5aUlmS1lGdmNvZlpvNWt6WDBjQ2w0NEhjN2JFODJocnJHNXBERHpR?=
 =?utf-8?B?a3hEb2ZreG5lZVNGUEovN3piMFNWdjFKVzlXRHdYbDBrRS9CNXQrNk5oNnlR?=
 =?utf-8?B?aXZYaU5BdUdaV09pcU1OWEUycXlIMTZMZW9aSDY5bmFsQ0NTSE1KMEdESVlY?=
 =?utf-8?B?RnphSkRqNkloWWxsM0xacDVtNkw2UUVBc2VCb2dNRmtQVVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(41320700013)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q25NQ1duenl3dlFMTTJyZWExSkVqQWNaMWo4ZGpZLy9GZWwrMHBydzYvQmNT?=
 =?utf-8?B?ZmtFNWNxNUEreTRrZGMxMUVGem5zc1l5SW5KdEdzL2ZGbFFwTElERThEb29T?=
 =?utf-8?B?VmNqL1ZROVNYZ2RzSXhnYkQxQmdhRU9QN0U1YURRM0hpaU9JblZJSlFvTTcz?=
 =?utf-8?B?WjZweEgzMjdReVdUdUhyVDRjNitpdW9STU5wTmhUM3dyMU10cWNka215dit0?=
 =?utf-8?B?S1NvQUc3aGtkNTE5SjlyUDk2ZzdicDhTRVEvRlNBNThwandLb1FDcUIyNWRL?=
 =?utf-8?B?U3J2WHRRWTdYRmcwL0VMSHRWcFRYc2NnV3VQTkhNNXVjeS9seENyTGFaMHMv?=
 =?utf-8?B?WDdYVGpnaHVESnhZYVVaSFptYmQwSVhQRktianN6VlFxZ3JaL3hzVWwwNGpa?=
 =?utf-8?B?bnl2am5FdkloRnZuSUJubk5rN3huY2J3dDdwdXp6cHdOYUdzUlVCbkN3ZWlU?=
 =?utf-8?B?Wmg1WWplczI5TVFTRDdYSjQvcFUvRGY0TVUvVnBaOXNRQURPbFZIMkpvVWtN?=
 =?utf-8?B?SnpsMUljN3RjSmp2OWZ3TzFKT2d0d3kxaXdnMkFad1dvMWx1bWRCUUMwYlJH?=
 =?utf-8?B?Y1lJdkhFcEM1SEZ6MU5Va2NkVWFQVVlwenBNdytQMm94SDZCRDcvNjJhZFBL?=
 =?utf-8?B?V2g1b3JGaEVkb2ZURmw1SnBaYXBGS091dkZmV01kSGtWV2VtUDRnc3lHckFN?=
 =?utf-8?B?aVJ6NkJRNDZCVmRhckRZSXBXcnVuZkprenBleWtPY0szcVpVY3RxMnVueSsy?=
 =?utf-8?B?TXpOSnVMUFhEOWRzYWRub3NVaTA1bkJwOTladkh6MC9sYkZiTzArajVjMmdR?=
 =?utf-8?B?L3VnaTl4UFFpWGtadHlXMnpmcHM4eVhUNmx2RWl0L00zTGtMVHlBblBVV21P?=
 =?utf-8?B?VkM3S0wyRlNLa2RDVU9iMzBVUGtpRHBsY1Rqb1M1Zk9GQkhnaXNITHA5Sllu?=
 =?utf-8?B?M2s3aUZoNldEeFZaRmVEUEViVTlCSFZwSjRibEtPNHJ0V0dBY3VuYklGbk0r?=
 =?utf-8?B?ZG8yWHY1ZTdOSHkyZ0poL05tUjczcnRHaVppOFlrUWIyTWZrZU9tKzJHZFBh?=
 =?utf-8?B?clhKaGgvcFBiODRuUElaUGhHS1BVVzVsbk9GNTMzd0JMN0ZVZlJPaUwzVXNY?=
 =?utf-8?B?bjFsMHd4RW5XbWdIQS9hSVdDMGV5bllGdTBiM1ZFQ3ZaY1dKYkhTSVZFMkM5?=
 =?utf-8?B?VXZWZmF5cTBncklDaTVJa0FHeTJrdnJZRmROT2JmQ0ljUzg5eHJQWUpBYjRy?=
 =?utf-8?B?QU1ic1RvNDNLTFhxL2pwRnVxZFRIekdMcmNjbEc4cWpsMCtCZDUwQU13b0lt?=
 =?utf-8?B?em12bC9lREJZSlB0YVFIWk16dlVQclZZNHRZRHNsM0JmbWhHbWtlbWRsYXpt?=
 =?utf-8?B?aHRNZUdBZGdaaDZjZEI3OU9HUXMwWEU0NXE4QmtjbGtiQTNIWnNjcVM3Q0E3?=
 =?utf-8?B?TG9PVzFiVmx4aDBtNkNOVkUzMG10Y3BkR1ZFZFhKZHp5WGduUkN2cnEvSzZR?=
 =?utf-8?B?RnJXNldncy95WmFMYzZib2tTVjVjVmJtL2VYQVlGOU1ZVWJ4bFdleWV4UHRt?=
 =?utf-8?B?M3lGd0hSZ0x6bFVxMDZhL21JQy9USDNDK3FxdC8xZnYrc3p3bkxuYUpqL1R2?=
 =?utf-8?B?NndEcnIxTmU2Zjl5bkJzVkE4ZWFaU0RjQjVobHF3OVNDWlhEOEE2dS9pejVZ?=
 =?utf-8?B?Q1dOYytnbWN5L1o5d2tiNkFnaEVFZDc1WjZOTXRTaU1JS2pzOFFsR3lydzMx?=
 =?utf-8?B?Y3hyOHpGdzdOK3k4WnA5bkhOWGFUQXhWaEhOS0NVbXhweGNpbStFczN5bWhq?=
 =?utf-8?B?REVua0ZWNDlpTXpvbEp0eUMvelpOU2dCUC9mTFV6c2U5TzU1by92T3pCV29m?=
 =?utf-8?B?QlMyRVI5a0Y1Y0tJR3lmUlJiYnJQRWdsMzAySlFkVWJRaThiOHFPcVdnaEw0?=
 =?utf-8?B?WUlTQ0NPcXVEK2pkbEo2R3ZRbURTck9KYkNlc2YvRGZFK2VQcG1rTEZQL2Jp?=
 =?utf-8?B?U2RIaHR1a283UHlDYTJPNkt0dkt6ODNOOC85cnlQMGFDVi91TC9lUmVhdEhW?=
 =?utf-8?B?aTlyR2RXVGJuT1VSMXdNZFU0T3V5bmUyZ293N1dJbzZlQzlXM1lXMEJCTy9O?=
 =?utf-8?Q?QbtU=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: cc72d21e-6fac-4c40-df2b-08dd79201d88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:41:40.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CslvLTY79jXTw8hulumudbGQSxibh4CbytiAoeb9Gh3c/WquuyKYviv0XKX7anghBQaTEJ0LUjbzO+6nH+Vaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR06MB8199
X-Authority-Analysis: v=2.4 cv=D45HKuRj c=1 sm=1 tr=0 ts=67f95455 cx=c_pps a=sf1zYAMyThzbrKU8SMWnlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=WSMdPYEYCNyMuYSXtLsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ewleC6ZCaomDa77lQ6VeHAEdqM8OeTPE
X-Proofpoint-ORIG-GUID: ewleC6ZCaomDa77lQ6VeHAEdqM8OeTPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=744
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110111


>> Are you interested in working on joining the noble quest of getting the
>> rest of the nohz_full support in place?  (Full disclosure: This stuff
>> is non-trivial.)
> 
> I believe the request is more of just tracing entry and exit from the
> kernel, which just needs a simple trace event at the border crossings.

Yeah I'm more interested in just tracing this for now.

> It's been on my todo list to add one for page
> fault exit (as I do care for how long they last.

I've added a tracepoint similar to page_fault_user for that but I'm not
sure if it's the best way to do it. Should I send a patch for review?

Thanks,
Junxuan
