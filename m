Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B148C3F3;
	Wed, 12 Aug 2026 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569876; cv=fail; b=TyPIaribMLs4mXiWlMYusE6vCplAyeUU0qX6n0Xx2HYNKzfm2Ai8QB7h+Hb03KxNwckojWhXvHD6SJqu40bCk7qLVRi9Qo5lX0CoCODsZxFCA47cAeDnPIP2kP2T+99Vm/38OKCEZNeThbadD0WZfyBiDTPT9YZl6Oq0oZiKhKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569876; c=relaxed/simple;
	bh=ZQ2gQNqFqIven/NWWHxp6yO4j2RBRb8NLqEvvhvAFPo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kqMS2HazInkL2wn7790DTNOQD/9HFSoKPHlz7REj9pav8ipqtu8P/QvUoqKLxvO78FoAPiSqJSEfrD3OEKbiC8NUmp3CnXCBswx/b//pPrQfZ78IsczWWy77yAseRiMxAj0WCBtFUrZi7Epcxqcy1Nm9iOuKKL//7EddmeL7OLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MxrAHX73; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MxrAHX73"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfa62djdd/JN9ODP+zNUTJA+s6pP5wlnj08XnBMm/gzubhtHH3DBet8BndzplQjXdGr6K+EfjQbWbCGvewjroh/QgRxLJxUFkTt/gaoo18jNmQjJ+ElDE3bkwPwTLWa/3ao8zFAev/g3tJsPxwGTkdzDvVCagWCJtMJt9+9ygUEjIa73UAOwPNI4vXoBItsITnMLjo75PITSlvIDYfX5kdMJle8+pCd7kAG17bysYPP45XHg9pc70WDOaD6i8/iqcsbicppbr92Eew4R5eWaH3qPuLD3h4B5R44lrwKX3xI21o2TpBmr951QP7TmVXLEtQj++IqIEUuomxE0NMnw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha6jOpM0h+MXgP7LvEXSxUQtQ8ZXqyO7kz02H2qiiiU=;
 b=Uj88LK0M3yXghY4QOQio6nmH9huQCcJRoxmXihBaCR8uXdw4HC/Y8+RtlpWMfYDRZL1Ja8DRMftQzaXqEH8wyD3nEjfrqAAiz3hPazGu1E+byworSKQHc/l3wJpdiEELvkjcmI5MQoxwAOwO9AVEaINJBFpMAs+dW+KXN4MU/JJx/cQb6Y2/uMTv2XaCz4YQd2UZ6pt9RjiurDQ1NokN+i513B/FyQE39XPB7aNHq2AHpPuUzfH7h5wUj9nwSuOLTKoCIJrOVe371XYhDjO9U9TuukIkOTzQ7+xmb5zr+ilev3hdVT6BiHJfspcaT0I8DN710PKb6KTKzf1Ut1EZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha6jOpM0h+MXgP7LvEXSxUQtQ8ZXqyO7kz02H2qiiiU=;
 b=MxrAHX737h7r3913tM3mvmyERttYQJynjMl92GXL3QPQWvKLabyGVfvHhars6By4AGL1ppku0pHzI0bKQTNMhrOTHV3nhzYulawdsFeuOdUJF/x0qLBwgZUNB9/07JUCbQZgsp4ApuFj13XFH2j33IqYjStWkjv0Ay4/qRnh8Oep7TakgUFa1Kn1kmzIZlgl3xvvmBgp7l0oYqH7O6/3rMQmYY9+t87DzLhBC3sTg2/sEaHincTIYGP3c6SSgaHGlmbCwdwTGj9nM16Wmtg4PNpPKqm02k6Gwwy2zHcHZwBZ6jlpO+QmrdTs7YJuMGFxrAhWSqtyUTNTEZ40WaRDNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11821.eurprd04.prod.outlook.com (2603:10a6:150:2e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 21:24:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 21:24:26 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 12 Aug 2026 17:24:08 -0400
Subject: [PATCH 1/2] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-dma-chan_dev-rename-v1-1-a67131f7d5c2@nxp.com>
References: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
In-Reply-To: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786569857; l=9109;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PDosGW0CD/B66+z51ntfn83KdAhvhxREfCe0V361xGQ=;
 b=2WjtUbPVSbMMF1zFSzfbeRa9kuJS5fZMsnN9fyou14PGipDsQL1x9wlJWMz1F7T3mSmnObkLo
 x4xtMsYRbZMDd8LAGKpnezanHap+6DvAbMyLsvJysceRGU8t1O0KMsv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11821:EE_
X-MS-Office365-Filtering-Correlation-Id: 562ea4da-8b92-47a1-4460-08def8b8163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|19092799006|921020|56012099006|18002099003|10067099003|11063799006|6133799003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	xDq3FexuycHnQKh8OfC8NNOjb7cVRHgLdTjHfyVStlid8YRaAIg0ca7vWcBXlIhDlzSSf8JmzbcoWfHmLpm4X3QD9n3eHs7ZJtPyxUx8IKWuvGBVG1qFFOVw+Y8ToQ69PDib7DE2mQ3Nkx3mex0kcaZiK4zA3DdUH0ig3pdnuZRVfTE2G5EqA5TWm2wqdRsrBpyQRiqvaf3cNYf5kXKy+dGL9byAPJmmO9c6h+vNhYZRLV6TuKekjpOlBuiW/WGS2jdnixdny3WdfhIPwReANEcI2siCC/+Ty3O87Bds/UC9+wJIKZ18edgXeqSMez8937FlDcbOo1xg+WuhuqawXRQy1Zpi/QNF9mFihhP68CMxR986dHq2V7vMChczm77/N7jtb+zQRGvMxUH3vxuZO7A8yw+RVt/gSY3swDID+x+9jJt51UcygNiltfD7y+cybRZvwPLXcyxFnu7yKDKFC7agg+fJWiLp2X5/CtxXZMnkAhjMe6CT5sE3jgthppWWZiNDmvFIUhIeThrceWywns1VaJrZr31ul2Qfgne/hfR5eDoNGP3xvU6xYhvhnN1apKJOw1HNVrxgAzvBnPy1XRX6s01hqE3ixPImxFVijAAkCu2lzMlM4xo2UHCefOQGL5dshDNrijmkCHOETfe8lwPEPcJADFSF1a2gksA45YCwqWjLELeMHsf+n0TZdESd7M3TJqlmWJKkFxYMmAEjDo3OVVAIQyllIGTa6mzOZXr6P+yg96xaza0tpOPWFUC6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(19092799006)(921020)(56012099006)(18002099003)(10067099003)(11063799006)(6133799003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHd5K0Z4R0lqRXcycEpaNHplUmRCUVpISHlkcFpSdjhYOEJrVWFqTTZTV0Qz?=
 =?utf-8?B?NGRETlRWWElsRjVmYzVVSUwvZjJzbVlSRWFWUldESDd6bGFsRHhZM3ZPcWly?=
 =?utf-8?B?Y1ZMT2RzS2gyUk1Zc2xlcm5aa0JBYmhiUWlidlFaVVVYejNvOTZYSmZUZjdV?=
 =?utf-8?B?NU5nMXlqTE5mRTFpQ0VJWGhCVC9Ua05YemZieVlSQnBGR3ZBY1JDS096Q25N?=
 =?utf-8?B?cEY2TUN4UU5UZ2RZaWgwZzBzSndvWFdFdHdzNmNveC9aTk43OUQwMjVHNnZM?=
 =?utf-8?B?V21mZkl3OUJ1Q3piLzFRS1BXUnBHeHlRa2dNUS85K29iRmVhRkhZTEkzNjNP?=
 =?utf-8?B?UE51UDBDZHNIc0xGeUhkcllGQkp0L2hxQ2VGQWFwNGo2UTBiMi91USs5Qkd6?=
 =?utf-8?B?VXArR1J4aEM4VW1jUEZ0bzUwMjhwbVFFRHhrRVdMMW10NHJVUWlINmpuMTND?=
 =?utf-8?B?TUpVQ1RJL3hyblVpY252UkliYVRid3pCWXAwTEJKK1dVOHYrMWFhNzBPN0xX?=
 =?utf-8?B?dzY1SWYzUGxFVlhOOWVPZUNPajhxb3BkaWloVHJKMlNveERUMER5SGc0Z2py?=
 =?utf-8?B?QnpWbnRFQ2J4OUQrc1IvdVd0bWN4aWRxV0lTaXNOU09hZEVXWnlRb1RKM2h1?=
 =?utf-8?B?aGlNcHpNWGhTNVhjeHd0bkltS3VuSkF3NkIxd050MXhMbE4yTmNKNmxtOVZv?=
 =?utf-8?B?VDJFaDRvM1FYMUs3d1RER2U3VGNFZGFnbCtnSnozbVpYMkJmTVBiTll0R3pt?=
 =?utf-8?B?bmtmb3FJWUlRTEp6enlGZmI0Z01FY0EvUGh0R1BYY3dPKzlUajNadHhFOFpp?=
 =?utf-8?B?U2o3bitxZ0RKRGFHMXg5aFRIR0cwZE9zektvdm41NGVGd0FUVTg0NHI2SWZa?=
 =?utf-8?B?VFVQdkR6L0JOdUlGOUFYWkxRNVV3MnhmaHZRbFhuSWxkNGZua1VhSVVDMm1x?=
 =?utf-8?B?TTVHZTdLWTNSTndMaVdnM2ordU53bDFiQnh1bjNVQnBQbHhDLzVoSVAvRHZy?=
 =?utf-8?B?bWx2bCtzQVFCNURsNkh1MzJqQ1hyYTZZY1J6Q1RNSkJXblMzYzNWaG16bEZn?=
 =?utf-8?B?bXJ4QUtMeUxjalhuUWsxeUw2U3hRMlU2V1ZQVFl1dkRBbGNvdy81VGVPdFdM?=
 =?utf-8?B?WmdvT3IweXpPMFNwaFhYbVpQdzZTcnJoTUNwZjlNa1Q4NTVoMHpjZnZLeTdh?=
 =?utf-8?B?N2pmNkQvb0JOTlJqMzV4ZHhPa0dQRVZPR2FxcGZld28vR3plSGZySUhXUGsz?=
 =?utf-8?B?T05Qb3R3NmNYVmFFMWRwZDVSRndZZEc3OVZwK0lOM3lZb1d0Tkp4YXBKNkhD?=
 =?utf-8?B?Rm81M2ZGSjhPZldYcENUYUFwVFdqNTZUVElnQnVtUnY3N1B1bHJuUU1kSlg5?=
 =?utf-8?B?aGhCS0VIYU96cTlRMFY4T29YZ1g4R1Q2WjBqekdGNFhPOC9mb2Rsd3FsWmFH?=
 =?utf-8?B?S3JLRkNVVlJJeXpJNHZGVXcwcXhqRlhxRkk4N21jbzlxNUhaLzFPN0JWTWds?=
 =?utf-8?B?RmNsM0cvSVJycUZHZFVMd0pnZUJFTGJXRkJxOVM3Q085R2JoMU9rbWpRbVpX?=
 =?utf-8?B?OXNNdU4rd1V5aUw3eTBGdWR5MU9qM3I0Mnc4T0tQb2ZjQlBjeFBKVS8wRlJz?=
 =?utf-8?B?UzJCSFNmNXVpbU8yZmViR0xvUzlUd3laZjhDeXgzZmNDTjBlTFBpYUNGdy9G?=
 =?utf-8?B?OEd2bENOWHNqSEtjYXRwYWVDMHJIZWM3R1JINy9BQTA0MUtpYUdFUUMzZWFp?=
 =?utf-8?B?UnZ5K0tPS2tMM01tQ1kvSzFoRE5OUTIrTEl5akV3OGkwTE8wVFJCWVVvZzhs?=
 =?utf-8?B?VElmRzdSRnBYbVhTSUVxZDBPZXZTc0VMS3ZsT1NpQjJXeTdmMmJQUVRPSXRs?=
 =?utf-8?B?dmVkTHdiTHZoTUNXUFBBSmFDbVBVTUJEYkpDcjJLM1hCUU9uRWdJaU50b3g0?=
 =?utf-8?B?Vm51OUZjUE1tUENueWdjZjZRc2EyeVBzcE9EWlFUUEM5K0IvODM2TU9ZR2hZ?=
 =?utf-8?B?VzVpWVJhVHhzT200NitsL0R4VW1OVVpQaWxQaE8wckFXbnhadFlrdWdyamVK?=
 =?utf-8?B?bXY4OHdIZXZZWjlmang5cGVmZHE3dDJxOTNFQk41VHBXcXJpNXUwTnFyL3RD?=
 =?utf-8?B?d1AwVktqRHczYldjNXgrVUpESmp2d3Q3M0J0Q1l4L3RRZWtUK3FoSzY4Sy80?=
 =?utf-8?B?cm5QaTlCRDZmQXFTbFhIcy9QeTAwMVdZSmVSenNDdWo5dkJ5T2pLQmk2N0VP?=
 =?utf-8?B?amhsZnZhRXM3SVhTL3VKVndTS2NiSE5DeHNxcTNsWExYaytaMVlpUXVqVlFK?=
 =?utf-8?B?L2lSUTVTa1BGUnVrWGZkNEloQm01NVlZZ29STVpqeUVWWEdIU00xeU53clo0?=
 =?utf-8?Q?sCcQayZmGWJ53F+X2Q/XlHObi4xUafnCYsC8x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562ea4da-8b92-47a1-4460-08def8b8163d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:24:26.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/6SbnOSTs36RHZ6k+NatEJy9crS4G6ktoLDPXQP88n4YdRFHjvEynrZJe/ik3/wm9yNCbXzM4PG9HySBQG5GdtDCSMWZIyeEIyzyo/oiv2Iy7CoqTn5RDupLBjfTHCK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11821

From: Frank Li <Frank.Li@nxp.com>

Use the existing dma_chan_name() helper to obtain the per-channel device
name instead of open-coding: dev_name(chan->dev->device) /
dev_name(chan2dev())

Simplify the code and improve consistency.

No functional change intended.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/arm-dma350.c                       | 2 +-
 drivers/dma/dma-jz4780.c                       | 2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
 drivers/dma/idma64.c                           | 2 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c   | 2 +-
 drivers/dma/loongson/loongson2-apb-dma.c       | 2 +-
 drivers/dma/mmp_pdma.c                         | 2 +-
 drivers/dma/st_fdma.c                          | 2 +-
 drivers/dma/stm32/stm32-dma.c                  | 2 +-
 drivers/dma/stm32/stm32-dma3.c                 | 6 +++---
 drivers/dma/stm32/stm32-mdma.c                 | 2 +-
 include/trace/events/tegra_apb_dma.h           | 6 +++---
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 09403aca8bb06..89673a5fca304 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -512,7 +512,7 @@ static int d350_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
 	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
-			      dev_name(&dch->vc.chan.dev->device), dch);
+			      dma_chan_name(&dch->vc.chan), dch);
 	if (!ret)
 		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
 
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
index eebed2474210d..d24902374f742 100644
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
diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 1c9a542edc859..f53f24b7f8ffe 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -678,7 +678,7 @@ static int loongson2_cmc_dma_probe(struct platform_device *pdev)
 			return lchan->irq;
 
 		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
-				       dev_name(chan2dev(lchan)), lchan);
+				       dma_chan_name(&lchan->vchan.chan), lchan);
 		if (ret)
 			return ret;
 	}
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
diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index d3ad78562a140..4e3ecb6763036 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(&pdev->dev, chan->irq,
 				       stm32_dma_chan_irq, 0,
-				       dev_name(chan2dev(chan)), chan);
+				       dma_chan_name(&chan->vchan.chan), chan);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"request_irq failed with err %d channel %d\n",
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008e..ab0fb05597363 100644
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
@@ -1892,10 +1892,10 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 		chan->irq = ret;
 
 		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
-				       dev_name(chan2dev(chan)), chan);
+				       dma_chan_name(&chan->vchan.chan), chan);
 		if (ret) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
-				      dev_name(chan2dev(chan)));
+				      dma_chan_name(&chan->vchan.chan));
 			goto err_clk_disable;
 		}
 	}
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

