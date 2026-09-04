Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550533CF1E7;
	Fri,  4 Sep 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558612; cv=fail; b=Ud0Qw8ZHptVVu5Du/D0KH9HnGC82rKJ0TdDXaCcDa3DuMbOyS5m8M+neiWBQ58ERtB9f4xwhne986MOg5xpjAn/j54/9pVHmN8eo1y5AFkx3C5pXdElHxxAqD3apMPdDh7AbUbohjhYC30HisgSY8IoP/jyrMIcAw4Ira37cYAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558612; c=relaxed/simple;
	bh=h60rf5UbjuSAb5W0ZT2gxInSKCjwoe1HMwHZDA9Wz7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T5viSLhZjwbZmsF6/19PFefAUCgNQl55UjtG3WsnwfZBaNgelNoSXSP+GGVKHIOjI0DVvSX3pBUIf8RjORKWlr+WQvPYzILRp1xR/L/EzoDGvWqXH9X/8eGnIkrZehkx+PzaKAGJ5m9WRTp+twHHAWJNvGkgvSwNDprOOu+/LVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V0rQqhDK; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V0rQqhDK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtQ+p518TIYWgTtrqrMqLiNU/t8NkQ5hr9smysTXpW6wnJxNvyYiplv76dYRpLyvaNh5Q8aelW/yNKvtVW6+aRimesYDHQGwWvtk6RXIzQ6g07RYs5wu2qBCggybqSFSiHQjkGBoxy2gzDYIfITZvdMqjTZ3k4LXYEyOZQiD4FfxWMpxGgATZh8hE+N3yzbiUvZzoZSK7XIdbNmTAV5Kb1UkhuPYM595tyImStJstjzTeQQnSaj/BLcvC0Y9zQOABBqZhTEYkLjzGbh1R8QUjAcNPEXFzrJiAt5qdXzkemvAClATqdXLENQg8mK44cW5IigydU0nheFup2X5Ms8w7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIrtL3aikHbKSqShfTCH663/0vOwr1XhVsAFtET2HvE=;
 b=fNMyAq6FPX7/YZ+LnjYX1ezho4npO8tA5ArgwwYLB3StjBWLIwz8qynPX8XAs/DN1Zn9IL3zuaQrCqYCvfUqnSVK3uv/OqEKt8xOgju4UOq85441oJgGqAgvszLyDegI2sFPTliEoFjd2BuPIC+GZ7gEnYgM0c2WQcWSvap4+p1qUGycieRNtSnyVf3t+d88Gx1MwfTW1mDXAagw9p55xE7eMW5hIlNeDLW7Y+OowUd2FfaKvs5xhBeF/nHfTqg2SgysEtR8KwkZARv4eoOuZqdhJbb1rbyequO8jQ7gTK5P7ZC7TOc9aEOaLkiihGWMuvsmTuimbilasurDalxfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIrtL3aikHbKSqShfTCH663/0vOwr1XhVsAFtET2HvE=;
 b=V0rQqhDK2zi+7sJ9O+IC0dqrbgbHdRnSjQmwGariDie4YNi7/yIAwHC71BmNWiHHD37JfAH7wdmvMg0NJckOqUr09lMivEeHqskeuz9H7sV4llzHTocfu93erav1MycXeFE2y8z4CEflaWmWEt0HVEQbNP8Zahz0uy24ykUIkM9lUgQed3s/HVs/pCTLmoF5Rtw0mwFQWnIUjjyFXjFwKH7Uw85y5fZrxS/AJkhm5Oq0BXYgUHuRN9cOaOZKG4qN05SUlnyndkxSsfo104QSrVCoKlh9iApSaOYNB1t2fQMITGVMf/WTkb5JA0l+2klLeL03UJsckXzot50glH3Lwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB5PR04MB12227.eurprd04.prod.outlook.com (2603:10a6:10:64a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 21:50:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 21:50:07 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 04 Sep 2026 17:49:43 -0400
Subject: [PATCH v3 1/4] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-dma-chan_dev-rename-v3-1-685601b0b788@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
In-Reply-To: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Binbin Zhou <zhoubinbin@loongson.cn>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Viresh Kumar <vireshk@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Kelvin Cao <kelvin.cao@microchip.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788558597; l=3695;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8jHlCxUSDmTqFQA8Mc67+lAJmYQGqw16V760AwED3Qg=;
 b=mNSw5+mMGgM+QP1SENW+LXMmRXaEf6xX/gv6GC/l5FkhNETZ6hM04gWjHOQSt3DPNMW6Bv0UZ
 zMqM/0a/tqGBz/HD+2+DySnGyIR7Xv6WUaC1AyJbN22DDZyvx0mKVi5
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY5PR15CA0255.namprd15.prod.outlook.com
 (2603:10b6:930:66::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB5PR04MB12227:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a6e1e5-ac6e-4482-6b5e-08df0ace7c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	dp3obXCp0aufjCSsUw0RqtHfTxyBxJTAK/4vPAM/WVjG/jIc+uYuH04TmWT973BhQxbbWI75uBlk8WZZPPr8TEKDWQhlCbrmcKrxWHxEM0fTOH9j2fN1CW7cpPId1tVZgYxadKpLDdWuxOVIksfCkl1D9p6s7JBHBYLbuHyTIBtZW/0wkcGEhK+M0lQ65koa7FAMX1pFxv43ZKM1vobnl+x5VE9pnysJrW/ijTHWBcfYsjl99JOyVvKAj+lhMFpXRMvhN/kuGKb2qc01gz0Jy1fZrLKrYqW5pAz6eqHT/DxCX/rbuSZHESKg8iP6WHesYwSddU/oCzFdC8alqQMeI9fgtHh1chOiTpJ67farJh++PHhWwxn4KLy9MVXlS4ZV5vXPaNWFt2HldM02OUgTuJyFGYTmDY6EU7ai7vKsWwSr1vI/7/cJAsSAvuVbZyUCjjjASZV5YiWdsUvFPXL1aRRcNJOs3oOqJC/PEk74D11EPfydjnJIQJaS1mIcj/WrItAjLdzAflh7XNgBbN0YfOp8/4GcEHlwnGi+9fgiIpLewCheLJU8PkemJWvu0AkauKsTRxzxJBfBwZ4wu7vFuxHw3yq/0MBb21leZWfM75tgrp6paAjbBIOA9Tf1LGoGSCMP2pbCXbswN/giFnIxLsiwJgVNoX2+aVJcbq4jdofRURw2KGkG7NCP2dlfORpGXmou/l75AOM6xVV8qgOP5O0446YrOlQ+pxjvEXoSlMi8SqmyxzzD1dCbXRQXZ9CR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QytDVENVek5VRS9zWWpYNWxQV2JDdmpFL0x3bTdIVUlOQ3huZ3VVb0h0Wmw5?=
 =?utf-8?B?M1hZNTVnb1RXeWJKOE9CeVlEdElGUDQ5aDhBSzlsRXpVdlVDM2tGTW5XVnNl?=
 =?utf-8?B?UVVoTU1QWkV1eVVHZmRvWWdZK1M1T2hMUGFMKzBkL1ZRL3pDcFdmSEhxN01j?=
 =?utf-8?B?WHVHbzJkdUxIb1R4VkhxOWNWNXRoZTY0bGFSQTNjMUl1Mm05emtIbzV4M2Jk?=
 =?utf-8?B?TFR2S2hMRzB6Y1IrVWFTdCtWcFFIT2QweDY3ZVFqSGZzWDIyZUc4Z21SeFFX?=
 =?utf-8?B?aUhZTE8vR01tQTN1QkJublBUVmhqL05IankxeXJlVW91ZlE1WVJ4aXlBc21P?=
 =?utf-8?B?cmlxaGdCTFZNK2pZY2FVbWtKa042L2UrRjVjL2dUNGZybEN6bzFtakdjV0Z2?=
 =?utf-8?B?eHFXdDRCV3hmNVBmS0ZTcWdadloxa1JMbldVZG1kMjIxUEVvSC8yNlltaUsz?=
 =?utf-8?B?MnVYamptUHJKcmRsNVdBOWJsYWYwRHNDN2ZiRk1LRWdLUnVpa1JUZldOZkRx?=
 =?utf-8?B?Q0JYaGdoZUw4TE1PUHMrMWNzem1ONUxVMEVBUExHUUpCdWc0TWVFTkt0UDBV?=
 =?utf-8?B?SjliVzFqWUVSNHNPQThaS3N4NWhRSnBkWFJsSExhVHF6U1pteTYxQzdHeGgv?=
 =?utf-8?B?ZTNCcFhZMjZmdTZhQ0xvRWJRR28zSW4xSXlNOFlGMFFPYWJSeGl6dVM1WVd5?=
 =?utf-8?B?Y25ZRXNkVjc1WGV0dWUrWDVZR2UrRlMyZE5mZGwxZ1FLY01NK1VuTENSdXpY?=
 =?utf-8?B?bEJ6aVhDMEJvOFFJUkRKV28vcHVnRVFLU3oxQ2QrbXB3TWJ6anNiU3RJeHBr?=
 =?utf-8?B?bDBHaU1lZHJvSWlqQVN3dFdwOUl1VkpQRm5aYmZQWWF1ckx4MkdVNWdiQWhM?=
 =?utf-8?B?RWhKbC9nOVRWMDNuTWJ5cHRZazVoRW5LNC93QmhXMFVJYmdBVXc0eEl5UFFE?=
 =?utf-8?B?bkdUODdSTjV3NXNRWFJNRThmUEhrVTFRNGtia1Q2YUxQNzJGTDJyOUJNdWJW?=
 =?utf-8?B?SFdtMVVQb09RSjJJZ21ZQjdnVXFEUllWbWJaMzdCTUJPVWp3ZFBFWVlXNm15?=
 =?utf-8?B?dkVueVA4WUV6WWY5cXh2SXY0bUJDZDlFWXNWandDcDM5SXpGc3YxZndES2dh?=
 =?utf-8?B?WlkyWnZoNmhwd0RCU0RSOFF2VHdLaEdrak8rRTZIcjdNM0hvblJlaUxRSURh?=
 =?utf-8?B?Z2oxZHVRcFZjbGJsbmRGYlhjVjdyRkhaNTdtT2lmdEFacXlVOTBBb1B5VTNM?=
 =?utf-8?B?cGJRaXF6eHlHUWVjN0ZqSWFyOU1QVGlndWVCZlo1eURTcGxTOExaOUtudmJs?=
 =?utf-8?B?dUM1ZDczL1M5YThJaHlvNTY4QU51QUp6aWFwdE1Jdlp3NzhsODhUeng1VHYy?=
 =?utf-8?B?cW1BQndCUmlrWjZ0M1V6MWlUSjEvRXJvTHhGUU03RWE4SlBVWG91Q2VQZ3lS?=
 =?utf-8?B?WjZVQW8xZ2tzb0U0ZHNhbnREMWVJemlyTzJzaUpGU29nUlpId2RqZ0gwNjh1?=
 =?utf-8?B?TG9PMmw2K2FtRE4wSzd3YW5KYlpZVHRpZVZrK0pSOUhRY0E1RjRiUHFBUCtG?=
 =?utf-8?B?bUpMSDQ0SGUzNThBWFJSMW84Q1Z5UjVCL2NsM1A5a2VqZlJjTCsvMWJybGpi?=
 =?utf-8?B?TUdrbHcwRDMzcm1vT0lNYnllYXdYMHhMWlFEMWJXSjNmRGFzNDJuUy9kdnVS?=
 =?utf-8?B?dWdLS0ZZa1Q3UkY4clRDeG9NRjViTFB3azNMcWlQejI0L2F6alViTnB0U3dY?=
 =?utf-8?B?NGc4K28zSVUrOWk0SlRScmpBTk9uZGJWZW41WVc1UXlpbit3T1hFdnZ1SXdy?=
 =?utf-8?B?ajBJMzQzV2Q4Zkd5cXNwU0ZsQzF0TGIyQXNsVTdJNEY3UDJGeElBWFUxMWVE?=
 =?utf-8?B?ckd0QjFNZEl2YnpQSVJxY2ppeFFDR2hJSlpWTDg1MmI1QkQ5Tk9tK1BqNHVs?=
 =?utf-8?B?NXo2YXZMZTRnNGRPd05KTkczQWM4ODc3aU5yTG8rNzNmL0FXU3MrckUvR0pD?=
 =?utf-8?B?VGxmTEpNczBXcG9iK3Y2WGQ2b3lidWp3bytsY2FRaEhpZjIyRVJqSmpGMldH?=
 =?utf-8?B?eUNIczBOQWxOS3ljRm9WYTdNNU5iekNVNFlqVWhFM3BMWWlPd29JUHRzdjZn?=
 =?utf-8?B?SWVaamZKN0RLdlorcS9DRlZmTWxJWk9jKzFYYzZFZzdvc1Q4RG5ZVGREVGFO?=
 =?utf-8?B?NUNLd2ZnY1JqRlk4WXNLVm1kME94cVhhNU9wWG9EMm9Sc2xISHcwUnBZSlFt?=
 =?utf-8?B?cGtUbDZrRzB3cXJ5VjU3c0phWGJCZzl0VW96K1RmWDQ3MUp5SXBKVUFXT1B1?=
 =?utf-8?B?bXRvaG51T04xTkxkaG0yUnBTSGN4Rjdld3IwMWVyMXlHV09rcFJFOVNHdDZY?=
 =?utf-8?Q?cNZZuiY1u2tnDYVfPZaZRFWkSRVDlIh0S0Jvt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a6e1e5-ac6e-4482-6b5e-08df0ace7c4b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 21:50:07.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flpYhjY4n4Ro5KVtTU4TxGlBpj7Jd9HqgwjRAQ6beZO8XMIAMR0USEHVad1sqxvqVDaElDNro5YkpDedYkZoLKTNPSuczEcjUbVqAxDX060tydXw56VVHTWkDTSq9/lI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12227

From: Frank Li <Frank.Li@nxp.com>

Introduce vchan_chan_name() to obtain the DMA channel device name.

Use a dedicated helper instead of directly accessing dma_chan::dev
so callers remain unaffected by an upcoming rename of the struct member.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/arm-dma350.c                     |  2 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
 drivers/dma/stm32/stm32-dma.c                |  2 +-
 drivers/dma/stm32/stm32-dma3.c               |  4 ++--
 drivers/dma/virt-dma.h                       | 11 +++++++++++
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 09403aca8bb06..52f5242ea3327 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -512,7 +512,7 @@ static int d350_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
 	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
-			      dev_name(&dch->vc.chan.dev->device), dch);
+			      vchan_chan_name(&dch->vc), dch);
 	if (!ret)
 		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
 
diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 1c9a542edc859..2f1c8c4fd0654 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -678,7 +678,7 @@ static int loongson2_cmc_dma_probe(struct platform_device *pdev)
 			return lchan->irq;
 
 		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
-				       dev_name(chan2dev(lchan)), lchan);
+				       vchan_chan_name(&lchan->vchan), lchan);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index d3ad78562a140..3e8151e2ad75a 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(&pdev->dev, chan->irq,
 				       stm32_dma_chan_irq, 0,
-				       dev_name(chan2dev(chan)), chan);
+				       vchan_chan_name(&chan->vchan), chan);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"request_irq failed with err %d channel %d\n",
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008e..1ee1bd22703fb 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1892,10 +1892,10 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 		chan->irq = ret;
 
 		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
-				       dev_name(chan2dev(chan)), chan);
+				       vchan_chan_name(&chan->vchan), chan);
 		if (ret) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
-				      dev_name(chan2dev(chan)));
+				      vchan_chan_name(&chan->vchan));
 			goto err_clk_disable;
 		}
 	}
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 59d9eabc8b674..dd023a3831209 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -209,6 +209,17 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
 	vchan_dma_desc_free_list(vc, &head);
 }
 
+/**
+ * vchan_chan_name - Return vchan DMA channel device name
+ * @vc: virtual channel
+ *
+ * Return: The name of the DMA channel device
+ */
+static inline const char *vchan_chan_name(struct virt_dma_chan *vc)
+{
+	return dma_chan_name(&vc->chan);
+}
+
 /**
  * vchan_synchronize() - synchronize callback execution to the current context
  * @vc: virtual channel to synchronize

-- 
2.43.0

