Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560D45561E;
	Thu,  3 Sep 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468831; cv=fail; b=DNUNjzqBr9WVMWwA64tVHi0b5QSHdccxHHN6gqWEdN29XYWzizcnXGPL4LXjFWqifhssxM6n7S6Fnychg8bVLInBbEd41tKzr5Cr2qy7dx5ShqnNJZ38sDs6H7dGtW3jn4HeMOdo7PuB16g5gxaM9slNAgqSnvZb9U2igEGHKsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468831; c=relaxed/simple;
	bh=0gmZ9uH8xVk/INqqbU45P96LKQoeN9AQ8Kqlk1PeZLg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MN2tksr8yfpzVtBOGk7P71Wbae3iB/E7hoaoHRWTl+KWRzzMgSfVTIr/ImoI+fe+RPxgzr66Roq2seRWf49qRrQxaOsCJu0W+S/qWZVX/8C1MLZb/m0PpifM86BODFQ5tNYpqkDYh8fGOPT/kHwXCr3qsgzWJcbsdl42XhEf8cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rWpHpdU4; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rWpHpdU4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjUXjXfuM7kyZZ8CAd+SMXdF6hmLQk+Bf6Cpxu4DOu4KlehVOVRDFfX1gK/g4KFfmL/DFyZCXgsY7fopjvJhMiV9ONit75ATgzDz1+WXNhY8F+7/9TpqQ9K3wcxbNWieVyp7ZAFy96A/I0KBiJtFsKEMiSsEjPEcfO/VirR21fmuTzZvZt4CwCfnbNVkR+5ZdXjKsesQ1xHWIMpFuRiBbb6lgGnzQBci7joS8QKiFWsSFyfRvrxfQ0xJ94xiK5sXNdi55dFKuZOigPvC7tGokG9BZQjpraKhOSt7YrP2Je7ESHU/WuapMIyIMzjY0Am2bkCCZlltzOXNBm8PmY5h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qP02nSnH5OFNSEU41007RiHO3PL9MvYi8mDl9ljJNk=;
 b=LvYhMQP5shLSOkbEGuN31VW4KQ+gprAnCpgE7TOm1M2MBAL4RbV6s2Id2xABV8ToP5RrpQu4cwPEaOKbGpThk0NGUxobzg4pv8xty+GfodMMN5sdYkD6DlLxZjpqr3WQJDDbfTjGpgdamwxQpe3p1Q2pBI3qPH5hgy2c97kiaxVbr0LutqeZIVqV2juARcsoYaU6T2NJldFDpQXyBMHvu4BGCNJa2IkcDUTgVIyyfEG2X5ZqRn+7P5cO8qEYxwe6zAgVV9ROoHjIe0eCrttUCGSH7NuYibb0HsGfBN50Mg+fHdQv2QFdrlMaotq8wD9EvAVESZG+zwfn++YRj3h5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qP02nSnH5OFNSEU41007RiHO3PL9MvYi8mDl9ljJNk=;
 b=rWpHpdU4bhDaNRCovK+T8Bdlue8+9JMG1x0G6luSa+IjvzHm7J8w0/iTe+8ZRGIlN+ZXpJLbwaV8v3arCuECwJJLDGkRZkcVPJwnD4pa/bcE5iMe1Mf2ihE6OeM/fZCA+TR715oZJbkcm52lhe9MXIEgd0ERg+rTtlJmsS8vEOT4cXWnVN3kN1dfacSz/8NDzPL/J1ZGyofEj15c8hTDot+Y7ALQOjn0hpXwdZ2fk2s1+QDzESYmYguJ7PCkbtb3FnkS7RyGm4Y1Yrmy15hISrlEtW8V+7UdvV/ALJFifuCsPm3c8so9/I4jAp1kLEL3cvv5tl1OaIKZF4RngLAXPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11894.eurprd04.prod.outlook.com (2603:10a6:150:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:53:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:53:33 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 03 Sep 2026 16:53:12 -0400
Subject: [PATCH v2 2/3] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dma-chan_dev-rename-v2-2-0db305b6c716@nxp.com>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
In-Reply-To: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788468796; l=6794;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/qlG6GU1Acam6GOeE+dDPCJ/BECdBAfo140IcCTsq/I=;
 b=nBWze121emtoyk/QNAMnf7ao8O90nlhlDhu3upjnd4w6MbJD97PbPkllTSLByawWAy/hBMtqI
 B3BEW7EuNYWAxyO2emTQzoc0Ic4i1uX4IRdQNG50cwpctEst5jkhwxR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:510:f::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11894:EE_
X-MS-Office365-Filtering-Correlation-Id: b5396acf-c80f-406a-dce7-08df09fd6aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|921020|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	wLOk2zT4DxwgLPR42hhAplfn7sivQ7ZvJgOqYTIDIjaQTL1ivTkCLK6S8VWofKL+SFi3BIQHqXk2nzUnX7YugwXljLQo1CRlXeH1MKwH0RIfQNCgjo+D6ztWPkOJBkATBs7D9mPGVSSLFO/PjFKeGI1y7JMS2gY8+JjCUjvwnIVh9MniDF9kcnAkkZwicSLzeSCMCNAzrpjbus0pI53dGvX/mUG+4eXNWzP9Rq24tBwYknnyeqLZpN0GIXGv5VtfoL7JzbSMZmwFaBXQ17p2J/StGxauR3RyOMh1SyjF+/PQ78xcmlGv5ceBcNtG946q4VOlwjvkiwaV2SxtiC/aEGoyxtr/+XzviDC5bvVF7Jshoc4DcoiJATap40H+eaEwQnE/X5JhsovGQYEs3WSagui5T5qTe82aT7Ykt9OUvIAamVipF7iwCmfVeLWYdZczdM3r9X/ArrCzOllqK0HPESt9DOwMtwXeHMAnDjR5Z4Yghdx5X9FGceFt4+LZRciK106UogGwQnu6xxgl/dltgit325OPe4D8ok/0EqG5lHcte6/C2/sh7gy1FHGg3RS7IyU5lFX38CYwQFPT06/9pn9lZBoR2kk20XnCdr6TK//DMVHUHx57ssPF9JwwkSskfpxRf7t7CnhFiADUlESESOYR8a1aCOhjKzKw4DROFCd5EREn6wyeA5X0BWYj3MjTlghHcxE0302DZptfefGWvsvQvO09xkSm+PDbpt17rc4KDNAJPV41YoLwf3N7H1g9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFOMFdhRUU4WGlxeG5LY25rNGZrbndGdDFhTlVOMVlDcHovT0lqaTJzYWJ4?=
 =?utf-8?B?dGdCN3R6Q3gyUXdMaVJqQ283ZFVjUnVFbEV0WEtkK3dzbHFhVENDWmU4V0sw?=
 =?utf-8?B?VkF4WE9KeXpVOXc2TmJNZzdZNUU1NWorYWhpRkozdmFpMmpJdXZkWFhaSWZq?=
 =?utf-8?B?N2lxWDBDVDNMMVJQQmJsbnRnYXltaG5XOEZzL3NuZ2VkR3RlMm1vcG53ZUs1?=
 =?utf-8?B?YU5ta1BUay9IaitiT0xLODZpRVJkZEdjVldJUnBESmJSSjBya1M0a0dGZTUw?=
 =?utf-8?B?dGpZSU5yWlJnZDgrMUFCMlh6aHBnQjFBZTlkRFQySnNHNC9RSWtDSmtNajVO?=
 =?utf-8?B?YmN5NkIxS28wU3ozWmpiT05wTi9TSzVtUzVHMVhpTUkvVTduVjFaYWFOOUdN?=
 =?utf-8?B?VmhHZUxFS2g5c2tPb0pRa1M2LzlkenowV0taaXdpdkZKVHd3NWU1akgxemgv?=
 =?utf-8?B?Q01QUVdVdC9uNW1VZjU4WGlNbW92bzJzQkVHcjFGSmJadEtUYllSSE16UFZL?=
 =?utf-8?B?ZFBkN0RaV2ZFd01GNWgrdG5tTkhkRTZLR0JqbGdUcFJvVzhGNUtWYWRQUWt1?=
 =?utf-8?B?RldVMlRTZkYrd1ZudFZUWmt4c2NPNklnV3duUklESVRxd3dJL1pWMU1BMUtq?=
 =?utf-8?B?eER2YVpaQVRxRmFTZUR1a24zSSttVm9mTSsycHZOai9KRlFZQStFb0NCUU9r?=
 =?utf-8?B?MjFDaUIwNk5BajgweE9NN3BZWmZ3MGY0QXBoOW5NVWJLQUZZWUJqcHEyZDNz?=
 =?utf-8?B?cjVIdGJYdkdvZFNleDZlV2NJV1hOQVR4Y1NrbGtJbkc0cTlqOEFuZHV1WlBC?=
 =?utf-8?B?MXNkb0tsSmV5TTREWkMxSkNIaWZKdHRRcldadk8yelVkbUVYSWdnNmJ0RDcy?=
 =?utf-8?B?WXBYYmRYQlJ4dmIzbm4vbW5CZjlLbitvT0V3UmxnRE5WckdGR0I3Z2ZkT0JD?=
 =?utf-8?B?a01pNW8rYjZ3RlU2UDg5ODdvaWNLU0RPNTNBSW4yVFdTc0RGUEFiZ1BaRHFs?=
 =?utf-8?B?aFlTSnNWOFFZYVZlRHltTGVQbXlzRXRFN2kzMFc5VlAwbTNQak5MOTk1Z3R2?=
 =?utf-8?B?aWwyUkFZd25weHJ5Q0Y3L0pKZUxwZVI1RmJyT3VhVEpoMG1yOXJvSE5XYkRa?=
 =?utf-8?B?bjZpMmtPMUVXNWZwRzZKaHByL24zTDE3RTg1VVFUUlRWSjdJdEpKYnEraEpK?=
 =?utf-8?B?RDlqVHN2aC9URmplS0dWV2E2S1VQNU9Ga3lBYlh5YXV5UjdQaU0xdDlNYVZI?=
 =?utf-8?B?SVBFMk51THpHZDJaMW5sZDRDcWs3ZkFOeEFLeUNleGo3c05sbFkxY29ER0lH?=
 =?utf-8?B?ZkdhT2tZcmFML0xBTjlHTXpETXFNOW9JcnhyTGpkWG9ucVpWZE02V3B0L2pz?=
 =?utf-8?B?ZEdrNDE4akowMVJLUlBaQkVpeVpDc0dlWGd2a2JNNy92Mm14YzcrL0NJYnZz?=
 =?utf-8?B?T2dWNk5HWTJiUDU2OWgvWURDRzRDb1Y5TFlSekliN1lldWM2djhURkU2Q1pP?=
 =?utf-8?B?eWtBb05NYWlGV0xCSnVwKytUbjhmWlVXbkhDZmpDbTZFOVNrelpGd0dqTXhh?=
 =?utf-8?B?Y2NHMmRXb2h3OTFoVHZ5dVF2Z0U4TE0xeEVVMXJIekpkTVRYcDFoUkhjNExi?=
 =?utf-8?B?T0tBNWNPTjNJejN5VkRQNkxPb3F2QXZXSU1GdFNzQStZNTBwY1RucndrVGN6?=
 =?utf-8?B?aXBjbS9aVVExQ0ZaMG1qQTFlUGpsYnpDd3dUaGFaM0M2U2NiTllOWVFKVERv?=
 =?utf-8?B?UisraTFmeWdkZ0FyZkJNS1ZKK2xudmlPd3drN1UyRHVlTFNNNjZxK3A1VThQ?=
 =?utf-8?B?WHR4cEhGdURXRzZHb2ZaWjUvK05EZnh2R3lXV0VIN1l4RDdtT3NRd2gyeUFK?=
 =?utf-8?B?YjBwTTFCRVA2YThYbU13U2lNT1RPalZEbjB5aXZBS0lnMHRiakNjMldrbFFJ?=
 =?utf-8?B?SDZISVBjaFB2MVJVR0M5R0dnTUlzU2NZbFl2cW1BK3c5aEYyUEZxTGgwK1l2?=
 =?utf-8?B?R0FLYVlQOTA1WmZUNlVrRWpDUVpNLzdXQjR1Vi9HS0VGbnNnTk4yak5LVFdI?=
 =?utf-8?B?aVdHM0xXK0hMYkpmdVpFQzlPQ3V0MWZqZlk2ODJibGpHeUFGd2I5TGlqOEJx?=
 =?utf-8?B?cC81MWtBN1pLdVgrczdCRmt5KzE0K3VDWktXYlRGYjdaUG5XRUJRWDcyLzJK?=
 =?utf-8?B?QTFPbFpta2JiTXV2RVlZcEFZT1lsVzFqZklVZE5YVWh1Q2tpVWtRY0lxWVBn?=
 =?utf-8?B?OFV1VUpIK0o4M3A0Y3pzNVBoODJPVUM2dkkzcEk3R3RJcnFReWZXWHNqTW1E?=
 =?utf-8?B?cW81WlJoSzZhc3RQWUFMZXhNeFBKaDhsc2V0VU82amxjaE9XVlRYb0xhT3Jh?=
 =?utf-8?Q?vPBOgeQzGQFjyn65miyix7JeEmEMAPQP/oXMi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5396acf-c80f-406a-dce7-08df09fd6aa7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:53:33.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFUYRVzVhfH0YHOG+ZIeTKQkjKSD2U21DmqSEl7Oru9lfbNYhA4wmRSyctSGKR0I+FU3sekjz6z5FfbG1f5V9GaV/l2SoTay83/lvuUk+f9B45qmHpUWC+CI1DsO66cE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11894

From: Frank Li <Frank.Li@nxp.com>

Use the existing dma_chan_name() helper to obtain the per-channel device
name instead of open-coding: dev_name(chan->dev->device) /
dev_name(chan2dev())

Simplify the code and improve consistency.

No functional change intended.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dma-jz4780.c                       | 2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
 drivers/dma/idma64.c                           | 2 +-
 drivers/dma/loongson/loongson2-apb-dma.c       | 2 +-
 drivers/dma/mmp_pdma.c                         | 2 +-
 drivers/dma/st_fdma.c                          | 2 +-
 drivers/dma/stm32/stm32-dma3.c                 | 2 +-
 drivers/dma/stm32/stm32-mdma.c                 | 2 +-
 include/trace/events/tegra_apb_dma.h           | 6 +++---
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 6070dfdb7114c..194649811d02b 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -760,7 +760,7 @@ static int jz4780_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
 
-	jzchan->desc_pool = dma_pool_create(dev_name(&chan->dev->device),
+	jzchan->desc_pool = dma_pool_create(dma_chan_name(chan),
 					    chan->device->dev,
 					    JZ_DMA_DESC_BLOCK_SIZE,
 					    PAGE_SIZE, 0);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 9c21a5479437d..7b50ba507cb02 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -531,7 +531,7 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 	}
 
 	/* LLI address must be aligned to a 64-byte boundary */
-	chan->desc_pool = dma_pool_create(dev_name(chan2dev(chan)),
+	chan->desc_pool = dma_pool_create(dma_chan_name(dchan),
 					  chan->chip->dev,
 					  sizeof(struct axi_dma_lli),
 					  64, 0);
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 5fcd1befc92da..6399fd5408be2 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -507,7 +507,7 @@ static int idma64_alloc_chan_resources(struct dma_chan *chan)
 	struct idma64_chan *idma64c = to_idma64_chan(chan);
 
 	/* Create a pool of consistent memory blocks for hardware descriptors */
-	idma64c->pool = dma_pool_create(dev_name(chan2dev(chan)),
+	idma64c->pool = dma_pool_create(dma_chan_name(chan),
 					chan->device->dev,
 					sizeof(struct idma64_lli), 8, 0);
 	if (!idma64c->pool) {
diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index aceb069e71fca..7c3d7c3273955 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -282,7 +282,7 @@ static int ls2x_dma_alloc_chan_resources(struct dma_chan *chan)
 	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
 
 	/* Create a pool of consistent memory blocks for hardware descriptors */
-	lchan->pool = dma_pool_create(dev_name(chan2dev(chan)),
+	lchan->pool = dma_pool_create(dma_chan_name(chan),
 				      chan->device->dev, PAGE_SIZE,
 				      __alignof__(struct ls2x_dma_hw_desc), 0);
 	if (!lchan->pool) {
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 386e85cd4882a..6b29e15b0616c 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -565,7 +565,7 @@ static int mmp_pdma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->desc_pool)
 		return 1;
 
-	chan->desc_pool = dma_pool_create(dev_name(&dchan->dev->device),
+	chan->desc_pool = dma_pool_create(dma_chan_name(dchan),
 					  chan->dev,
 					  sizeof(struct mmp_pdma_desc_sw),
 					  __alignof__(struct mmp_pdma_desc_sw),
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d9547017f3bd6..35dbff5f9f1ab 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -268,7 +268,7 @@ static int st_fdma_alloc_chan_res(struct dma_chan *chan)
 	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
 
 	/* Create the dma pool for descriptor allocation */
-	fchan->node_pool = dma_pool_create(dev_name(&chan->dev->device),
+	fchan->node_pool = dma_pool_create(dma_chan_name(chan),
 					    fchan->fdev->dev,
 					    sizeof(struct st_fdma_hw_node),
 					    __alignof__(struct st_fdma_hw_node),
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 1ee1bd22703fb..6ee7a1435efb6 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1126,7 +1126,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 		goto err_put_sync;
 	}
 
-	chan->lli_pool = dmam_pool_create(dev_name(&c->dev->device), c->device->dev,
+	chan->lli_pool = dmam_pool_create(dma_chan_name(c), c->device->dev,
 					  sizeof(struct stm32_dma3_hwdesc),
 					  __alignof__(struct stm32_dma3_hwdesc), SZ_64K);
 	if (!chan->lli_pool) {
diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index e3bbdc9ee36ed..c274638e919c2 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -1484,7 +1484,7 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	int ret;
 
-	chan->desc_pool = dmam_pool_create(dev_name(&c->dev->device),
+	chan->desc_pool = dmam_pool_create(dma_chan_name(c),
 					   c->device->dev,
 					   sizeof(struct stm32_mdma_hwdesc),
 					  __alignof__(struct stm32_mdma_hwdesc),
diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/tegra_apb_dma.h
index 6d9f5075baa3e..c38117c127ef3 100644
--- a/include/trace/events/tegra_apb_dma.h
+++ b/include/trace/events/tegra_apb_dma.h
@@ -11,7 +11,7 @@ TRACE_EVENT(tegra_dma_tx_status,
 	TP_PROTO(struct dma_chan *dc, dma_cookie_t cookie, struct dma_tx_state *state),
 	TP_ARGS(dc, cookie, state),
 	TP_STRUCT__entry(
-		__string(chan,	dev_name(&dc->dev->device))
+		__string(chan,	dma_chan_name(dc))
 		__field(dma_cookie_t, cookie)
 		__field(__u32,	residue)
 	),
@@ -28,7 +28,7 @@ TRACE_EVENT(tegra_dma_complete_cb,
 	TP_PROTO(struct dma_chan *dc, int count, void *ptr),
 	TP_ARGS(dc, count, ptr),
 	TP_STRUCT__entry(
-		__string(chan,	dev_name(&dc->dev->device))
+		__string(chan,	dma_chan_name(dc))
 		__field(int,	count)
 		__field(void *,	ptr)
 		),
@@ -45,7 +45,7 @@ TRACE_EVENT(tegra_dma_isr,
 	TP_PROTO(struct dma_chan *dc, int irq),
 	TP_ARGS(dc, irq),
 	TP_STRUCT__entry(
-		__string(chan,	dev_name(&dc->dev->device))
+		__string(chan,	dma_chan_name(dc))
 		__field(int,	irq)
 	),
 	TP_fast_assign(

-- 
2.43.0

