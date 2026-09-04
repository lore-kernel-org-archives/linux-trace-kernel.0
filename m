Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE03BCD3D;
	Fri,  4 Sep 2026 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558618; cv=fail; b=P14qj0lOum1ihYTVoFVB/Mew2qQmLAdX61vgATx07sQQgo8fUwgmGwvWog2Jgc4nlROxV/CubgsHJ1h/Lkuh0J0m/t/Tc16Vd0Jbln6udicyxhRqylEEKfvM2/nhBvRZ+RrT8o4gOgLP/AKmQYbe7lR0yT51gakBTka3jAAKS+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558618; c=relaxed/simple;
	bh=0gmZ9uH8xVk/INqqbU45P96LKQoeN9AQ8Kqlk1PeZLg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WbChGCqmk7I263Uqqjl6rvQzi/y3Igd8E7paLCGM7jja9Ltp93MN20Qkj285R0Hm6cBjUn4+SXVad7sva2aWi3+iYYTd+T73glJqJXh3LBnWBwz0ib4cCBY98sAfnzBqCDa9RoTg6DyscLuvbARemYnQ0FD8wwk7bOgVdvSJGN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b1IUonFR; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b1IUonFR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxDvDBaj1SeXmzBS1j+3Wk9du0zx4GQIx+Htgo6ljUwGbOCap7SWY3SGuCin3qecwrhZb8mSfVPKMyP0cO1XPA6VVY5R2OZRunT0lJBdtDFF7Mao5kch0Mc4LvNr5JCgjh4u5+CoNRgodkPWh6UEj6NRzBFxl3fPbcv+aQpbqGu9tPO6s8Ya8N01JV7xrq+vQ/0an04+fUYOv5CAnS/Bnr1PxPqaLHSwMoRZw76vgY8laZEgeW8zgIF07xASbhjQXeYGOs0LQc4FzbuOA5cLPEDHyrz/jFgtQCqulySAtTu7F+xJrT9p5krNGK2vrpnfkudRBAK7eOwS0vuId89XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qP02nSnH5OFNSEU41007RiHO3PL9MvYi8mDl9ljJNk=;
 b=XbJos7t9mSpOiJQpeCFrejxsi1C4O/ZkuTkQv5KcqPX9lkvs2R3ZL/rhAfVxO4WIldEaQlEpqjZUs1k0SYaKKXDHI9lx4ns/OgJ+/zD66IpFWeCNK4bjhis018joyhpc+C2Fc8idYEs8lmuxWneurEjKV0w2MB2sRFB6gvkz5JXTjthVuJhN3K3rxsR6YKfU+oQOzfPc6OKsUf/woFeRENJxxqjlF/MHnTVYlh9iglVIPqMOecbb+CcZcWBBfg65w7A37NC1LBO8cD4RIevC3LkjvFyLRiGS96FMArYNJ4z/KL0m4Te3sfTex4RxPGrMsyMMd0tpcptt7x8q1auZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qP02nSnH5OFNSEU41007RiHO3PL9MvYi8mDl9ljJNk=;
 b=b1IUonFRX9NNUij30nsQwN+hdnJW2yyB7AZlybRo84T48qfF5vpYZ57mVprKJ4W5/jWzlZAwijcqqZHw79ZbyEuaX/iLMaYsmbA6HXX7VOJIrXgeESGBmVYOEbxV0DpNfLeAHNdJcG9ArS2JeJiOr1n+oTsR5wcdt54PeefTjz2ZEpcNtXbbL8z4lJ4l7mRQl+WOxFaa9ErjioRIqjpgzNN6jL7JJrzBEoB+rF+FXd4/qWSURgcVEifqKapI3yvhFEJ40vG+8Bvxwm6nRPMpy4a9g0vadnlm6qSr2aDTUHbcwTb98jTx/9HBes3jstAXTR1FWAEIRNmheYPYiRbImg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB5PR04MB12227.eurprd04.prod.outlook.com (2603:10a6:10:64a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 21:50:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 21:50:12 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 04 Sep 2026 17:49:44 -0400
Subject: [PATCH v3 2/4] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-dma-chan_dev-rename-v3-2-685601b0b788@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788558597; l=6794;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/qlG6GU1Acam6GOeE+dDPCJ/BECdBAfo140IcCTsq/I=;
 b=9DS7wmDqweV7G1s6pLPN7kPUHZayb+eszWsbF+EglPIvZ3UYC5ucmMYuaujj/056jiUpsyqFw
 sFsAw/Tp3h5DIo0Q9oeirRr+0LFRGLC7GdR3Z3YwZaaqG0rxtIAgKW+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY5PR22CA0077.namprd22.prod.outlook.com
 (2603:10b6:930:80::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB5PR04MB12227:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e011cb-c528-4e52-74f3-08df0ace7f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003|6133799003|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	yIPx3dO06DgC9WsDpEJimA9JSJfBzu1tCUMgRXd6ZJPLwtt1ql5ffrNS1rkys5Td61bzSW8LZ4xLtAruZ86WrQaG9Al1WCeA9vyROF3BVIIHDkUfsva3WLyGfKZwINe5txMCpVIKu2l3WPQOal7gF6xYb20N2UHB3q1lrgfEb6pDoyUHqnzArcN0ofF8tkmAKCXn0EnsA06kBnNFFRI698BVFTTbwaZvFkgR+ZGxd3Xdh1rONV7DRnPhtbf0ff33a89cAapRIFKHR1dsu6Gq2Ys7vFsEVaz2is+L6XlwqYcENNwuy64CGiKIJhIgSldnLNntdTEvBjNbfACyg+9Dgbgnog3lScL2ovYdd/rhtzTezsntJWBsZBJFyOOUbBOMD5AlgTSNmIid4m/2rBPpuhHzQS1fvY8kSc+kLDAzv8T80IaGcnMN7fmts4cXunUWUtZQvNDBKDXNrFvMbyaTfazcNbrKWXdfQDmQbjWJOKgf5/XBxPUvubBQzOgo4BDXknPXfaP9nfCKnP0/aHIgvJOCsTp5DH1ayVayZS+8vC47uxVhqOajBhzASAViCpr8Oz+kb3w8ifFvM5/7NFsf8h0a125m0PzhCj+TD7tw7OOSdcAt3i+sswb4esHxd5Dv+oVFImP6G3XkHWE4sWanIFNBvh/6QbdWGYsO8tD8F4LoR/GN/2sb202Pq4BJTabfAhDteOouFb271/zeOC2VgeoE+VPN+UBHsW+bo2iA71L8S7HLb5kLjuZa865psvbM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXl5Q0ZFc01CRjN1dDFGTTk1bnUxVTJoQjlRUldhSGZXcHcyRGZIQ2M0QytN?=
 =?utf-8?B?VkppWWVMKzEyOTJqaTd3TGtpUm5BRkdLcUdPbUYwRzZid0d4R2tmSnJTaml0?=
 =?utf-8?B?b2o0ZytxN3VHc29xSnowT0VRK2tIL2o0a01wZEVhZGcvYXNEaDdsbENLVzFr?=
 =?utf-8?B?enBRMVhmOW5YbzBrdXJYOUFING93ak1zVXdlK0M5WVBOU2lZVlU0bDVTemVR?=
 =?utf-8?B?NWdwSG1xM0o5ZFBrWEU3MzNUejNkRnlBbk5zNGt2aG4yMnJJMFRLNmlFSFl6?=
 =?utf-8?B?cStKRTIyTzM4aTZjenB3QThDTEdzWEkzOVpMcXRGRW16KzhSckF1R0ErWW9o?=
 =?utf-8?B?NU41RTcxQlJWQWhEMVFQZmxqR1JEWEtyQkVxcDYwVHpvQm1oSGhiMHpkVDNp?=
 =?utf-8?B?TXVSeG1MTkN5OCtpdVFPb01Pb3Bod3E2ckhYTmtPdHV3Vll0T0w1SnQ3WkRM?=
 =?utf-8?B?Y1RsQjZ3SG5uSFJKRlRoM1JYZGtET3djczJXMEQyR2c5Y2lwc1BESlloUmpL?=
 =?utf-8?B?MVlEVzd0K1o3RGlVazUyelFsZm4wZ2ZSaVdhamFldmIwT3k2QXlsZUNLV0xh?=
 =?utf-8?B?NVI5anJhU25JcE5wUjJsQlJPUVZwRVVFaWRwdlAyT1k5ZFRGd0xuZDNhUEx4?=
 =?utf-8?B?ZGtQMGc4OU1hbUpPcWRHcG9oTEdyb0k3MjVFUU5QTmNzTUlhS1F0OE9jSDJk?=
 =?utf-8?B?RGdFTHB6NXZCb3o2ZzNtMDRUbHVIMGo3bEsxWGtYVGpqdXA2UW9xUXhFYS93?=
 =?utf-8?B?S2xnQ0xQbzRtUy8rd3hicUszRlNOUDNGd2xJRVVDT1ZEdlA0UW9HbDJOUE9O?=
 =?utf-8?B?QmgyOERZT1JIaXNSaUZsa210QjhEVWF1RWdKbjMyeDNPZFA4S25GaGJZNTZa?=
 =?utf-8?B?RE5MVFh6MDhqb0N3d1VRcSt3Nm5DWFRJR3hscjY0SElUaVJhNXRmVno5OE1X?=
 =?utf-8?B?RWVQY2JXbnVvSFZndDIrekVBdzNHelNvRFhwWmJOWkNBNlhqVjJFQ0YwYUts?=
 =?utf-8?B?LzRXeWRpVUVFRVB2RkgxRXhXdzFtSEhZT05GdmthTlpoQW5mVG00Rk9VaCs4?=
 =?utf-8?B?TG1mR3lyV0RRR01rOEEydlZ3VGZHTzFHQnlaY0tlNG16Y0VGQU1HdVdvaGVE?=
 =?utf-8?B?VkFvb1F2RllSeDMxbEx6VE56SEpGWUVlY3lKU1dZMCtnZVlQTUE3MXJPYmtn?=
 =?utf-8?B?V3F5UHo5TzFMWjVaQmlZQVMzeVNFRXdDY3UrT05QM0MrSTNnNDVoRmhpUkdq?=
 =?utf-8?B?YUR0ZVJpdEVyYnJoakZqdHpJZ1VOSGFmZFR2dDhDT051UTdSNW1HZ2FFcVBV?=
 =?utf-8?B?Z2tHelRpV2FaeG9qd2QwTUxlYmd0UGN5QzlIS0FDSUpNNkYxTzVDMVJRSVZY?=
 =?utf-8?B?U1FkVi9MVFpLVVRrOGx0UXE0WEo1c2FJYVptWnNmS0xFWVdXQm0vWFVPUm1G?=
 =?utf-8?B?WFBHMTlrTEVFcmlXQ1lydHJiOEZCRFgzbGJjbW1FZEx6ZUFWY0doaUF3RDdk?=
 =?utf-8?B?dFA1ZXpSYUtORk9jVkNPTnovZ3hMN09ERjFoWUUzZGloOW83RjJjK3hvR3J3?=
 =?utf-8?B?UW44NWFsT2VrZWZ5V0pOenFnR256OFlnNFdackFOL0RxQjhVdXhjekFadDNW?=
 =?utf-8?B?VHZ0cUJaNXFHcmRHaXFFelRpUGxlemJKdlNHdE5lazRldHNpSUlPeWRMSG9t?=
 =?utf-8?B?YmU2OTBxcFpGa3UzUU1ZTnZrU0lTYXRzQytqWFUvaGEvaWFUdUpxZWxyd3di?=
 =?utf-8?B?YUZMUkcwTk1iUS9BSmRkYVNPZGczb3AzNjV3clFjYmx1TTBoa0NCNDNYOGt5?=
 =?utf-8?B?OS9OZ3I5M3NIc2FJWEJGeVJOUk81MlBRQURnSSt3MjgySDhqT2YwVFFRQTRo?=
 =?utf-8?B?SnUxdThwK3RBaUpXS0JkVGVKdXc3WXRmVERNQXNwcFJLMmxaOVVXUkJSd1VS?=
 =?utf-8?B?emJFMUVqZ2Yra0RiTjY3VjRyNVNEeDJFSFZCYzRqUlpaLzVBYTFFNDhVRk96?=
 =?utf-8?B?OGNHTHhxc0hheitsRzByNXZHQlhSMmh5MlhNRmQ2czVZZXpqMkl6WTVKM2I5?=
 =?utf-8?B?TDRUOHBIZnRIeGowNW1NbXhmRVNZQkRrQlJvTEtXUEUzT002YXVsR1BxUWMr?=
 =?utf-8?B?dW4zWDVWSWhPYlZhRVVpL094QzZkaXZKRVI0NnZBTUpBdUphTTU5b2tmcFFi?=
 =?utf-8?B?ZEhOdEMxM1Z4S01CeXdQVU42VnhmK3hqeHNnYXBoT2E5bmVBd3lkanNiUllJ?=
 =?utf-8?B?eDgxUjFVR2svbEVjSTRaSkhyQ29ld3VCMUtQL0twNmoyTmM5eUprcmFjckQ0?=
 =?utf-8?B?M1UrQTdMNEhsaXJud0E4OEdoZHZJR3pEVVEvSWdqN01hb3VuRDBFeis3TG9p?=
 =?utf-8?Q?LUIapEFTPMOPejmJ5/Q9NFBEJP1GCRUqtKWhm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e011cb-c528-4e52-74f3-08df0ace7f6a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 21:50:12.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA9czeuWTrNXHDHI2AdkXwqNh6CMsUZ2WZ6Z5J3NyD6LGhJ6hYZgWdHIEXNXQN3HuPkdg7OtCe5GpQa6RM1f7GPkvS6M4+7fA8sNcNvZ86sGgHs3G/mUUGXO7EoL7QAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12227

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

