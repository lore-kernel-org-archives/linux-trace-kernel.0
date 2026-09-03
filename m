Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2614F6491;
	Thu,  3 Sep 2026 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468840; cv=fail; b=N2t/f2aoslwN06lKFqnML3RbddjcRPl0W/3wVXpRuZaLMUyeIcHetQVbee/xTfSkIZn5thlDQn+wjz9ONzgMWzqhi8F2UBX26/pO66YltWBHEW9FD6yDhmiOxxi1D5AJtEcAIw1Myn4hWRAFznzUX39MD2PgkKxHdtRiBjQJk5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468840; c=relaxed/simple;
	bh=iRNWmllqGzpHTZ/pND7cikRs/wKxpBewCk8oti/s5R8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=asYa8/YQ5cUvGygqyJcjTD+RxHybBckBDcG0OhjPTh55Oo9JPdvsscugj0ZZi+nwPKlwPhkmQMhIP0UbHK4lvrcKzMgUYafRDLFd9pWIsZAgUlarIJflogSqzJw8Nz3j6zhvd9ijKXSKUXuHiO1kiKcM0CWygijkX7d4hWd5idc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LCHE8TNm; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LCHE8TNm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADSwT22ojeYV4ecMuGb5pfpJuZMqUaOQgrV+5gUDY6tOQspmGO0oYQJoquyPA8lImYN4jHRc70P2w7Ws1gE97WiAj2yyjBUbKvWxuLLc3RNIfcMVaBLsyQHRyUxqkUjlXNsEencsN8y8rGgj/rg/j6lExnceSf7yxJfd+8TWwM533iBNyy4aboG00Jh/au40jf6NvgzpjMlAneWCgRirhnu1A+WvGw07Db8NIQu5VrWP8q43Mo2qx1d6JouMic0FuIa2DR97SGEUf2K+0ZdFgfQ/4/nBMxYWAA/yOqk7i/plNvgI+plewM6szjaZS3CB1pkeetyX7ERxWuFT63ZOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLoxmu5JHY9gdVSoRX4JfMuzPCjWqHeOZQ1d1gH1cUM=;
 b=Lg99oC4K4Ijsxjm7+KMfA6yTZCV+uvFSsAgzqeT+zPey3dzMU1elYFd1NULRRDJyldxj7yDM+q9emV0LGe4Uvd6ot8XojajkfDjkNHUetVZtxXUVOrVwNtlPbcURg0sQbDkzIpVSlBKGrhEJHWoM6elq2BEHBdb2VR2GnHUObzp4PhyzFmcvuihqup8N3oQkzyk8LLBEGR4qpsAxtGke/CJOyj6w0ybU6ij22wX9u8K0f2XZ4pboOMpHWsTPS0FIswPGwuK1Klx45sz03ZJKtVjJ2fL53EMbB3S28Eq/jm3j+B6odxz63QW26K2FigwTcS4V8dLSgT/8hD+JcxUKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLoxmu5JHY9gdVSoRX4JfMuzPCjWqHeOZQ1d1gH1cUM=;
 b=LCHE8TNmLCTwafSQjRwR/RlBPX59I3EbwtZL/M1Q/tu/9fBL4Ml5nfDFFHIfKRpIJHpXHXA0zBL8dhBn8ZWoZ5LE9nwfLaU+Q0WVA277NAC1iRthgWcTLEKSH84SBtTw6g9wikaqvwlzDsocQnOf2lz5x+C33zndy32hGNFnXwNoUiEC5rfNbLhOTI1qZNI3oIM3WjKkr5t9OmGfJkdC19ApVyxMOyUSTbEIXZub6uwxQNIhrqk+bSaIGWfXH4eRuI/mgmyP32oM1DZT4JwgMwjjQfKm9uSBTsPmo/PGi3/ub0252yKxCJ5lesw06J2F3FAT+y9WK6kx/TWqO1uWlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11894.eurprd04.prod.outlook.com (2603:10a6:150:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:53:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:53:38 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 03 Sep 2026 16:53:13 -0400
Subject: [PATCH v2 3/3] dmaengine: add union chan_dev for dma_chan::dev for
 clarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dma-chan_dev-rename-v2-3-0db305b6c716@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788468796; l=30341;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9sa/oAlzKUnpgqIyEpl9TaONnsm/aCzrLvOCtEchlBs=;
 b=+CcmVCZrdN+7xpuh50oFQqkicNDG+maIQ69vYmLewjx5dssYbJPCq1Ppvek6tRNjCfqFqEu0d
 zH2sU9YOsYADzDCOBNIkvizPpFBBxZRCc+BtXB+bM2ZMUTa/T8aACrd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY8P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2197ef-92e0-4945-7828-08df09fd6d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|921020|11063799006|10067099003|56012099006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	AL0sOQErgzvMHzq5cMnMj0Lajdc+lQrEJfpKmRaEpZyPbzbGl/s4GeY7EaKNeqedQrDvRLu/FZTqJj96DsfWuQhglQdqNw0b8Aah6PONK+TbxZi45/91bdqUsLPz68jBLq15dne8XXu5kD7rz+V0CRMcr+nJqWBhfuv5V3TBKoOPBTfH208ffdmt8H2uXGYY+PwPuy5+mi034K31f5Oiyc5PUFkuKMFQcOvsIf4pO6zSGGNl7DyDUILrbFkIOmvsxddFBiT+Fgko6zs3CxqOEsN/YNlI74jdljUCqwS/08Ez+Td56AxhQtS5mxZtNvEjpVutlP8Vrrd8iPIfL4SiWY5vE0CXZrG6nNc+r5gmFY+8IrfohEqAsnVg7/2SN8G9w9kcMf7WK2o4D9jap28YW8GNM/yzZ3sDuGJMaGaXkauFz0xpZM9qG25+LPfBGWM/ydjxvXiA+iy+5WCrgJENoRpbGqo4c5J2nwqEg+P+8GTMAesFd1ig5mPljTKd4mSFXZEkhTzlLJdt/IK4DevpVKLGpou0Ezmpv/33rVx1n9ldWl5+MU/s1Qm5xuXl5zx/fdOOsLX8xzpPW2bDql2juTrrlUHRcXzcqmx5r68z2JNDssnWtSqUC4P6Wz/jaZVcyiIM4WusqPeygH/ZBr4PRyOQhAokpYX3d1RFXLwinNtWb9F9T8tZ24Z1X1ZydP9JweIpz2PFGf8k5BSkKk7kC71Rd66alp0jK4iS4Issz4PSLMvYuwrMRbjQFL1DbtJc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDZBaDM5SENkdmlVeVRDdHN0ZEx4RFk0L1hodEJVeWwrZ3ZGOGJ5aXR3aXRk?=
 =?utf-8?B?M3NBYUxacWJ4YTdkUlVPMnFMOUpGZlVYOXZjbm9wMDcySGtxek1UaktjM3Zu?=
 =?utf-8?B?SlU2WHpMUUV3QTNwcHdKRDNvd0kzZDlNc3IvVHQ2SUM4THhubTRlR0dKc1k4?=
 =?utf-8?B?azdDd0JyN0ZDUUY3MGQveUZTeWRMb296bmRySmVEVm5qU3haZEo2UHJ2dG1h?=
 =?utf-8?B?dEI4Rzh2NC8wK3ZoeVYvS0RadW5WQVNhN3dUVCt5cnJ4c2xmSU9ac09DSDMy?=
 =?utf-8?B?b3I4NFM2UmdBdGU1YVlzcDNJREpSNlBCbWNGa3VXeHpTdmxrNDFWTHk4ZkRh?=
 =?utf-8?B?YUNtVG10eWxHRUpCR25iNDEzcDhDb0I1cnFSdkdjVlZBRGV4aFdqejMySzhN?=
 =?utf-8?B?cnhYc3FIdkZHVW82Wk55QlhZTkV3NEw0MWhkTFl0eXlqZm9jNVRGSmk0aE9T?=
 =?utf-8?B?U2tuWjNVS09VT0pza1Fjdmo3aW9mWm5HS1h0UEozSC9hWVJQVGxXMlkwTG5v?=
 =?utf-8?B?QmhrYld1WkkxV0s3Q0hJMUxML3pUdlIwNE1idzAvM25LdGpHcC9PUjE4b3hK?=
 =?utf-8?B?REEzNys0b1BOLy9EZDhFTzMyUmRCWFdoa012NkcyNkc3TkpkQTNxYkhxKzNn?=
 =?utf-8?B?aDJyL1V3MmJ1WTNzSTBqci82OEtJVWdDcUtFUlAwVXYzdldiZUJUSWJWVmlo?=
 =?utf-8?B?QklqVU55cWJZV2tLWDdmN2w0dFZlSzZlSUR6OEJnK2tFMy80dUtHTllOaUNo?=
 =?utf-8?B?RFJRaVZXS2Qrc1FIdkpaaWtlRExIR1IxNnphQTh6MTFpOUVTamJZQlN3SjhH?=
 =?utf-8?B?NlVCMU4vd1o1eVpURHlPZzdSYmpWZzdLVXBISnpXRGVXTUlzOE91NW05L25t?=
 =?utf-8?B?Y0hlWWhjL20zRjR4L0krSlcrU24vbFVkWkRnbGxSVGZoRlByMEFYSTkxMzlX?=
 =?utf-8?B?OTltMEdkK3dpZkowSHo0aHVMUHdLQmZMaGtmSmZrVkJqSG42MnZmZnM0ZDcx?=
 =?utf-8?B?V1JJaTR6VTE4YjVoVzNiK1ZjR2tsNm1PUTExWXJxWG9RSVg5ZXU3WEJFaFRZ?=
 =?utf-8?B?b3MyaElvR1dOVUZlNzlyNmhlNmIwbmpiYVlSWW9XQlZmdXpDb2p6K0wvQlM3?=
 =?utf-8?B?S0h1Um4rdjBaNE1WRmxSQmd5KzNhaS9FQkZIYVYwN0VXSG04SEVKK1RIMzFz?=
 =?utf-8?B?cVZFOWgwS3lZTkJmNzh4ZXk2cyt2bklwaVkyM2JZTjNDWm1XMWk3STRxNzBP?=
 =?utf-8?B?b2RxdGppQS9Kb3FjOWR4MDUyeVFibStRYVltbHhrUk90Nkl2bG1WdmFteXpk?=
 =?utf-8?B?SFlzQ3J5b2ZydG50ZWpnVVFKQTJ4TzAraWNZcUVGcUdPclB4Tjl1WHI1RWEw?=
 =?utf-8?B?dDhoaUdVWVFMNlh4K1VFcFRiQ3BWUTA3anRyazJSZnBsY3RrNm9Nak5PaU9K?=
 =?utf-8?B?R1IxY056TVhXSTFEWHkxLzA3TlJiSkwwQnljY1ZQS1FGVjkxOFA4T1hrclhw?=
 =?utf-8?B?Vm1idkx1dEN2SWxFRjNEVDB5TksxdVBkRDdOL1hDTUtGaFZ6eHoybWRYQ0VY?=
 =?utf-8?B?MzEvWjlxRklQRVUrb1cyaS9CUmxrVDNoY1B4NnYxOGR2ZkoxYVNVTkc4ZFV1?=
 =?utf-8?B?Qnp2a0N1aFZhcFFYODF0SUVudUo1WHFKaXc1TXc2cHpTd0ZVZ1RCSk1xbmpa?=
 =?utf-8?B?N2ZHa1Zrd0h2YWpmL1J5OTlMc3dGLzZBa1duaHR3T004K3lwZXJZNmZZcERC?=
 =?utf-8?B?Q0xBVlJvMmErK3hrMGlxT0l4VUU3dEdMd2R5RXM4c1Fhc29Lc0FVTTBNeTVR?=
 =?utf-8?B?TVdVZEhtMVUrblZjc0J2L2xaRk5tbmJ4djJMeGhmbTlMaEF2a1JzaVo2Z0xl?=
 =?utf-8?B?MllDV0hCSzRSRkN6N3c4NmdpZ014ckJSd1cvNytyTEdRUWpQcGNOdjRIZEND?=
 =?utf-8?B?YkpNWUZ5N0xpQ3BZaFUwZEJVRmRlUk5GeFcvVzB4NjdlaWZtbFhnNXI4YUZ5?=
 =?utf-8?B?OGFZRGhGM1V1QVZ1b3hqYWIvbW9tTjZPeU1vOEdsdzFYQUd4MkgvVzlMS0xW?=
 =?utf-8?B?TmVDa2ppWmRhL3J4ZlNES1JCN1R6TGVFSEVXMVdveHhtdmNsOXVkQXFaeUcw?=
 =?utf-8?B?K0tBNFlaN1RKVXU4U1FWVzJONUw1eXBiN2hkQVhrc3p3RnFRSUZUNVlkSHBn?=
 =?utf-8?B?Q3R0OThURE1FekNwRzJmSlZ1Nm5pbGF4ZUE1VTZneDlzY0NEVjJJWVhHV1VZ?=
 =?utf-8?B?L3VabzFJU3RhUjZqS3FmbU13dGE1OWZ5SS80aU92elpVbGp5Kzd1WWkxQ1ZW?=
 =?utf-8?B?M0VDVTZGRUxNWDRIMlBpZnF5UFdvU2NFKzBHNGI4RzN5OVBOQnViUHJzTmw1?=
 =?utf-8?Q?2TmcrRBfK8ZP14MrGDOXwZJalEzSj6XG3vbGF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2197ef-92e0-4945-7828-08df09fd6d83
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:53:38.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr4+t2nu3xs6GPOZVUDkG8tm5echsI+p9ZxiMPODHBRnLezKX90tHcWRdZXGoAfWx/U+6Cql5iIFyofoiF8Ek+LSi9V/z+H5lTw67TXNtgdxTLTRiPrgCblSDL8M3+6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11894

From: Frank Li <Frank.Li@nxp.com>

The current dma_chan structure contains both "device" and "dev". So

chan->device->dev refers to the DMA engine device.
chan->dev->device refers to the per-channel device instance.

Their similar naming makes the distinction unclear and increases reader
confusion.

Add union dma_chan::chan_dev to make its purpose explicit and clearly
identify it as the per-channel device. After all user switch to chan_dev,
union and dma_chan::dev will be removed.

Update the kernel-doc accordingly. Besides its sysfs usage, the per-channel
device is also used by some DMA engine drivers for IOMMU mapping and
therefore deserves a more accurate description.

No functional change intended.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
there are other user use it outside drivers/dma/ directory.
---
 drivers/dma/at_hdmac.c                       |  2 +-
 drivers/dma/at_xdmac.c                       |  2 +-
 drivers/dma/dma-jz4780.c                     |  8 ++---
 drivers/dma/dmaengine.c                      | 34 +++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h        |  4 +--
 drivers/dma/dw/core.c                        |  2 +-
 drivers/dma/ep93xx_dma.c                     |  2 +-
 drivers/dma/idma64.c                         |  2 +-
 drivers/dma/loongson/loongson1-apb-dma.c     |  2 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
 drivers/dma/loongson/loongson2-apb-dma.c     |  2 +-
 drivers/dma/nbpfaxi.c                        |  2 +-
 drivers/dma/owl-dma.c                        |  2 +-
 drivers/dma/pch_dma.c                        |  2 +-
 drivers/dma/pxa_dma.c                        | 52 ++++++++++++++--------------
 drivers/dma/stm32/stm32-dma.c                |  2 +-
 drivers/dma/stm32/stm32-dma3.c               |  2 +-
 drivers/dma/stm32/stm32-mdma.c               |  2 +-
 drivers/dma/sun6i-dma.c                      |  2 +-
 drivers/dma/switchtec_dma.c                  | 14 ++++----
 drivers/dma/tegra186-gpc-dma.c               |  4 +--
 drivers/dma/tegra20-apb-dma.c                |  2 +-
 drivers/dma/ti/k3-udma.c                     |  6 ++--
 drivers/dma/timb_dma.c                       |  2 +-
 include/linux/dmaengine.h                    | 18 +++++++---
 25 files changed, 91 insertions(+), 83 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index f4d0c72787d13..5df429002950b 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -383,7 +383,7 @@ static inline struct at_dma *to_at_dma(struct dma_device *ddev)
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 #if defined(VERBOSE_DEBUG)
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 901971e8bae69..30ec996845ce7 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -326,7 +326,7 @@ static inline struct at_xdmac_chan *to_at_xdmac_chan(struct dma_chan *dchan)
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline struct at_xdmac *to_at_xdmac(struct dma_device *ddev)
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 194649811d02b..c48a46b2bbbf2 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -687,12 +687,12 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
 	if (dcs & JZ_DMA_DCS_AR) {
-		dev_warn(&jzchan->vchan.chan.dev->device,
+		dev_warn(&jzchan->vchan.chan.chan_dev->device,
 			 "address error (DCS=0x%x)\n", dcs);
 	}
 
 	if (dcs & JZ_DMA_DCS_HLT) {
-		dev_warn(&jzchan->vchan.chan.dev->device,
+		dev_warn(&jzchan->vchan.chan.chan_dev->device,
 			 "channel halt (DCS=0x%x)\n", dcs);
 	}
 
@@ -721,7 +721,7 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 			}
 		}
 	} else {
-		dev_err(&jzchan->vchan.chan.dev->device,
+		dev_err(&jzchan->vchan.chan.chan_dev->device,
 			"channel IRQ with no active transfer\n");
 	}
 
@@ -765,7 +765,7 @@ static int jz4780_dma_alloc_chan_resources(struct dma_chan *chan)
 					    JZ_DMA_DESC_BLOCK_SIZE,
 					    PAGE_SIZE, 0);
 	if (!jzchan->desc_pool) {
-		dev_err(&chan->dev->device,
+		dev_err(&chan->chan_dev->device,
 			"failed to allocate descriptor pool\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154a..c00641366c4dc 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -868,10 +868,10 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		return chan;
 	chan->slave = dev;
 
-	if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
+	if (sysfs_create_link(&chan->chan_dev->device.kobj, &dev->kobj,
 			      DMA_SLAVE_NAME))
 		dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
-	if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
+	if (sysfs_create_link(&dev->kobj, &chan->chan_dev->device.kobj, chan->name))
 		dev_warn(dev, "Cannot create DMA %s symlink\n", chan->name);
 
 	return chan;
@@ -917,7 +917,7 @@ void dma_release_channel(struct dma_chan *chan)
 	dma_chan_put(chan);
 
 	if (chan->slave) {
-		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
+		sysfs_remove_link(&chan->chan_dev->device.kobj, DMA_SLAVE_NAME);
 		sysfs_remove_link(&chan->slave->kobj, chan->name);
 		kfree(chan->name);
 		chan->name = NULL;
@@ -1083,8 +1083,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->local = alloc_percpu(typeof(*chan->local));
 	if (!chan->local)
 		return -ENOMEM;
-	chan->dev = kzalloc_obj(*chan->dev);
-	if (!chan->dev) {
+	chan->chan_dev = kzalloc_obj(*chan->chan_dev);
+	if (!chan->chan_dev) {
 		rc = -ENOMEM;
 		goto err_free_local;
 	}
@@ -1101,17 +1101,17 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_dev;
 	}
 
-	chan->dev->device.class = &dma_devclass;
-	chan->dev->device.parent = device->dev;
-	chan->dev->chan = chan;
-	chan->dev->dev_id = device->dev_id;
+	chan->chan_dev->device.class = &dma_devclass;
+	chan->chan_dev->device.parent = device->dev;
+	chan->chan_dev->chan = chan;
+	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
 
 	if (!name)
-		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
+		dev_set_name(&chan->chan_dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
-		dev_set_name(&chan->dev->device, "%s", name);
-	rc = device_register(&chan->dev->device);
+		dev_set_name(&chan->chan_dev->device, "%s", name);
+	rc = device_register(&chan->chan_dev->device);
 	if (rc)
 		goto err_out_ida;
 	chan->client_count = 0;
@@ -1122,7 +1122,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
  err_free_dev:
-	kfree(chan->dev);
+	kfree(chan->chan_dev);
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
@@ -1155,10 +1155,10 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 		  __func__, chan->client_count);
 	mutex_lock(&dma_list_mutex);
 	device->chancnt--;
-	chan->dev->chan = NULL;
+	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
-	device_unregister(&chan->dev->device);
+	device_unregister(&chan->chan_dev->device);
 	free_percpu(chan->local);
 }
 
@@ -1290,9 +1290,9 @@ int dma_async_device_register(struct dma_device *device)
 		if (chan->local == NULL)
 			continue;
 		mutex_lock(&dma_list_mutex);
-		chan->dev->chan = NULL;
+		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
-		device_unregister(&chan->dev->device);
+		device_unregister(&chan->chan_dev->device);
 		free_percpu(chan->local);
 	}
 	return rc;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 039316c42f059..05524ec96bcab 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -120,12 +120,12 @@ struct axi_dma_chan_config {
 
 static inline struct device *dchan2dev(struct dma_chan *dchan)
 {
-	return &dchan->dev->device;
+	return &dchan->chan_dev->device;
 }
 
 static inline struct device *chan2dev(struct axi_dma_chan *chan)
 {
-	return &chan->vc.chan.dev->device;
+	return &chan->vc.chan.chan_dev->device;
 }
 
 static inline struct axi_dma_desc *vd_to_axi_desc(struct virt_dma_desc *vd)
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index dd75f97a33b3d..d5618c128121f 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -43,7 +43,7 @@
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static struct dw_desc *dwc_first_active(struct dw_dma_chan *dwc)
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 311e55a97ba9f..977ab12c793e9 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -252,7 +252,7 @@ struct ep93xx_edma_data {
 
 static inline struct device *chan2dev(struct ep93xx_dma_chan *edmac)
 {
-	return &edmac->chan.dev->device;
+	return &edmac->chan.chan_dev->device;
 }
 
 static struct ep93xx_dma_chan *to_ep93xx_dma_chan(struct dma_chan *chan)
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 6399fd5408be2..6fdc0d50964ad 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -27,7 +27,7 @@
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/dma/loongson/loongson1-apb-dma.c b/drivers/dma/loongson/loongson1-apb-dma.c
index 89786cbd20ab5..03c8081e4b9a9 100644
--- a/drivers/dma/loongson/loongson1-apb-dma.c
+++ b/drivers/dma/loongson/loongson1-apb-dma.c
@@ -91,7 +91,7 @@ static irqreturn_t ls1x_dma_irq_handler(int irq, void *data);
 
 static inline struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline int ls1x_dma_query(struct ls1x_dma_chan *chan,
diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 2f1c8c4fd0654..69914778ead9e 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -136,7 +136,7 @@ static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc *vdesc)
 
 static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
 {
-	return &lchan->vchan.chan.dev->device;
+	return &lchan->vchan.chan.chan_dev->device;
 }
 
 static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id)
diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index 7c3d7c3273955..94f4364fbfb56 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -163,7 +163,7 @@ static inline struct ls2x_dma_priv *to_ldma_priv(struct dma_device *ddev)
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static void ls2x_dma_desc_free(struct virt_dma_desc *vdesc)
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 05d7321629cc8..4dd87cafc5e0a 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1202,7 +1202,7 @@ static irqreturn_t nbpf_chan_irq(int irq, void *dev)
 
 	nbpf_status_ack(chan);
 
-	dev_dbg(&chan->dma_chan.dev->device, "%s()\n", __func__);
+	dev_dbg(&chan->dma_chan.chan_dev->device, "%s()\n", __func__);
 
 	spin_lock(&chan->lock);
 	desc = chan->running;
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 7c80572fc71d1..ab7531a3a89c9 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -294,7 +294,7 @@ static inline struct owl_dma *to_owl_dma(struct dma_device *dd)
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline struct owl_dma_vchan *to_owl_vchan(struct dma_chan *chan)
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index bf805f1024f64..69d60b587c2bb 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -152,7 +152,7 @@ static inline struct pch_dma *to_pd(struct dma_device *ddev)
 
 static inline struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index fa2ee0b3e09f8..5398b47fec370 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -149,7 +149,7 @@ struct pxad_device {
 	({								\
 		u32 _v;							\
 		_v = readl_relaxed((phy)->base + _reg((phy)->idx));	\
-		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
+		dev_vdbg(&phy->vchan->vc.chan.chan_dev->device,		\
 			 "%s(): readl(%s): 0x%08x\n", __func__, #_reg,	\
 			  _v);						\
 		_v;							\
@@ -157,14 +157,14 @@ struct pxad_device {
 #define phy_writel(phy, val, _reg)					\
 	do {								\
 		writel((val), (phy)->base + _reg((phy)->idx));		\
-		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
+		dev_vdbg(&phy->vchan->vc.chan.chan_dev->device,		\
 			 "%s(): writel(0x%08x, %s)\n",			\
 			 __func__, (u32)(val), #_reg);			\
 	} while (0)
 #define phy_writel_relaxed(phy, val, _reg)				\
 	do {								\
 		writel_relaxed((val), (phy)->base + _reg((phy)->idx));	\
-		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
+		dev_vdbg(&phy->vchan->vc.chan.chan_dev->device,		\
 			 "%s(): writel_relaxed(0x%08x, %s)\n",		\
 			 __func__, (u32)(val), #_reg);			\
 	} while (0)
@@ -396,7 +396,7 @@ static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 
 out_unlock:
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
-	dev_dbg(&pchan->vc.chan.dev->device,
+	dev_dbg(&pchan->vc.chan.chan_dev->device,
 		"%s(): phy=%p(%d)\n", __func__, found,
 		found ? found->idx : -1);
 
@@ -409,7 +409,7 @@ static void pxad_free_phy(struct pxad_chan *chan)
 	unsigned long flags;
 	u32 reg;
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): freeing\n", __func__);
 	if (!chan->phy)
 		return;
@@ -454,7 +454,7 @@ static void phy_enable(struct pxad_phy *phy, bool misaligned)
 	if (!phy->vchan)
 		return;
 
-	dev_dbg(&phy->vchan->vc.chan.dev->device,
+	dev_dbg(&phy->vchan->vc.chan.chan_dev->device,
 		"%s(); phy=%p(%d) misaligned=%d\n", __func__,
 		phy, phy->idx, misaligned);
 
@@ -483,7 +483,7 @@ static void phy_disable(struct pxad_phy *phy)
 		return;
 
 	dcsr = phy_readl_relaxed(phy, DCSR);
-	dev_dbg(&phy->vchan->vc.chan.dev->device,
+	dev_dbg(&phy->vchan->vc.chan.chan_dev->device,
 		"%s(): phy=%p(%d)\n", __func__, phy, phy->idx);
 	phy_writel(phy, dcsr & ~PXA_DCSR_RUN & ~PXA_DCSR_STOPIRQEN, DCSR);
 }
@@ -491,12 +491,12 @@ static void phy_disable(struct pxad_phy *phy)
 static void pxad_launch_chan(struct pxad_chan *chan,
 				 struct pxad_desc_sw *desc)
 {
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): desc=%p\n", __func__, desc);
 	if (!chan->phy) {
 		chan->phy = lookup_phy(chan);
 		if (!chan->phy) {
-			dev_dbg(&chan->vc.chan.dev->device,
+			dev_dbg(&chan->vc.chan.chan_dev->device,
 				"%s(): no free dma channel\n", __func__);
 			return;
 		}
@@ -592,7 +592,7 @@ static unsigned int clear_chan_irq(struct pxad_phy *phy)
 	dcsr = phy_readl_relaxed(phy, DCSR);
 	phy_writel(phy, dcsr, DCSR);
 	if ((dcsr & PXA_DCSR_BUSERR) && (phy->vchan))
-		dev_warn(&phy->vchan->vc.chan.dev->device,
+		dev_warn(&phy->vchan->vc.chan.chan_dev->device,
 			 "%s(chan=%p): PXA_DCSR_BUSERR\n",
 			 __func__, &phy->vchan);
 
@@ -617,7 +617,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	spin_lock(&chan->vc.lock);
 	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
 		vd_completed = is_desc_completed(vd);
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(&chan->vc.chan.chan_dev->device,
 			"%s(): checking txd %p[%x]: completed=%d dcsr=0x%x\n",
 			__func__, vd, vd->tx.cookie, vd_completed,
 			dcsr);
@@ -640,7 +640,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	}
 
 	if (!chan->bus_error && dcsr & PXA_DCSR_STOPSTATE) {
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): channel stopped, submitted_empty=%d issued_empty=%d",
 			__func__,
 			list_empty(&chan->vc.desc_submitted),
@@ -694,7 +694,7 @@ static int pxad_alloc_chan_resources(struct dma_chan *dchan)
 					  __alignof__(struct pxad_desc_hw),
 					  0);
 	if (!chan->desc_pool) {
-		dev_err(&chan->vc.chan.dev->device,
+		dev_err(&chan->vc.chan.chan_dev->device,
 			"%s(): unable to allocate descriptor pool\n",
 			__func__);
 		return -ENOMEM;
@@ -749,7 +749,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 	for (i = 0; i < nb_hw_desc; i++) {
 		desc = dma_pool_alloc(sw_desc->desc_pool, GFP_NOWAIT, &dma);
 		if (!desc) {
-			dev_err(&chan->vc.chan.dev->device,
+			dev_err(&chan->vc.chan.chan_dev->device,
 				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
 				__func__, i, sw_desc->desc_pool);
 			goto err;
@@ -786,7 +786,7 @@ static dma_cookie_t pxad_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	if (list_empty(&vc->desc_submitted) && pxad_try_hotchain(vc, vd)) {
 		list_move_tail(&vd->node, &vc->desc_issued);
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(&chan->vc.chan.chan_dev->device,
 			"%s(): txd %p[%x]: submitted (hot linked)\n",
 			__func__, vd, cookie);
 		goto out;
@@ -809,7 +809,7 @@ static dma_cookie_t pxad_tx_submit(struct dma_async_tx_descriptor *tx)
 		else
 			vd_chained = NULL;
 	}
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): txd %p[%x]: submitted (%s linked)\n",
 		__func__, vd, cookie, vd_chained ? "cold" : "not");
 	list_move_tail(&vd->node, &vc->desc_submitted);
@@ -832,7 +832,7 @@ static void pxad_issue_pending(struct dma_chan *dchan)
 
 	vd_first = list_first_entry(&chan->vc.desc_submitted,
 				    struct virt_dma_desc, node);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): txd %p[%x]", __func__, vd_first, vd_first->tx.cookie);
 
 	vchan_issue_pending(&chan->vc);
@@ -852,7 +852,7 @@ pxad_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
 	INIT_LIST_HEAD(&vd->node);
 	tx = vchan_tx_prep(vc, vd, tx_flags);
 	tx->tx_submit = pxad_tx_submit;
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): vc=%p txd=%p[%x] flags=0x%lx\n", __func__,
 		vc, vd, vd->tx.cookie,
 		tx_flags);
@@ -891,7 +891,7 @@ static void pxad_get_config(struct pxad_chan *chan,
 		*dcmd |= PXA_DCMD_BURST32 | PXA_DCMD_INCTRGADDR |
 			PXA_DCMD_INCSRCADDR;
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): dev_addr=0x%x maxburst=%d width=%d  dir=%d\n",
 		__func__, dev_addr, maxburst, width, dir);
 
@@ -925,7 +925,7 @@ pxad_prep_memcpy(struct dma_chan *dchan,
 	if (!dchan || !len)
 		return NULL;
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): dma_dst=0x%lx dma_src=0x%lx len=%zu flags=%lx\n",
 		__func__, (unsigned long)dma_dst, (unsigned long)dma_src,
 		len, flags);
@@ -974,7 +974,7 @@ pxad_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		return NULL;
 
 	pxad_get_config(chan, dir, &dcmd, &dsadr, &dtadr);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): dir=%d flags=%lx\n", __func__, dir, flags);
 
 	nb_desc = sg_nents_for_dma(sgl, sg_len, PDMA_MAX_DESC_BYTES);
@@ -1021,7 +1021,7 @@ pxad_prep_dma_cyclic(struct dma_chan *dchan,
 	if (!dchan || !len || !period_len)
 		return NULL;
 	if ((dir != DMA_DEV_TO_MEM) && (dir != DMA_MEM_TO_DEV)) {
-		dev_err(&chan->vc.chan.dev->device,
+		dev_err(&chan->vc.chan.chan_dev->device,
 			"Unsupported direction for cyclic DMA\n");
 		return NULL;
 	}
@@ -1032,7 +1032,7 @@ pxad_prep_dma_cyclic(struct dma_chan *dchan,
 
 	pxad_get_config(chan, dir, &dcmd, &dsadr, &dtadr);
 	dcmd |= PXA_DCMD_ENDIRQEN | (PXA_DCMD_LENGTH & period_len);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): buf_addr=0x%lx len=%zu period=%zu dir=%d flags=%lx\n",
 		__func__, (unsigned long)buf_addr, len, period_len, dir, flags);
 
@@ -1080,14 +1080,14 @@ static int pxad_terminate_all(struct dma_chan *dchan)
 	struct pxad_phy *phy;
 	LIST_HEAD(head);
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): vchan %p: terminate all\n", __func__, &chan->vc);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	list_for_each_entry(vd, &head, node) {
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(&chan->vc.chan.chan_dev->device,
 			"%s(): cancelling txd %p[%x] (completed=%d)", __func__,
 			vd, vd->tx.cookie, is_desc_completed(vd));
 	}
@@ -1177,7 +1177,7 @@ static unsigned int pxad_residue(struct pxad_chan *chan,
 
 out:
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(&chan->vc.chan.chan_dev->device,
 		"%s(): txd %p[%x] sw_desc=%p: %d\n",
 		__func__, vd, cookie, sw_desc, residue);
 	return residue;
diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index 3e8151e2ad75a..5908782e66705 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -250,7 +250,7 @@ static struct stm32_dma_desc *to_stm32_dma_desc(struct virt_dma_desc *vdesc)
 
 static struct device *chan2dev(struct stm32_dma_chan *chan)
 {
-	return &chan->vchan.chan.dev->device;
+	return &chan->vchan.chan.chan_dev->device;
 }
 
 static u32 stm32_dma_read(struct stm32_dma_device *dmadev, u32 reg)
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 6ee7a1435efb6..78358d3734493 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -330,7 +330,7 @@ static inline struct stm32_dma3_swdesc *to_stm32_dma3_swdesc(struct virt_dma_des
 
 static struct device *chan2dev(struct stm32_dma3_chan *chan)
 {
-	return &chan->vchan.chan.dev->device;
+	return &chan->vchan.chan.chan_dev->device;
 }
 
 static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index c274638e919c2..a7ab77e4ebbcb 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -278,7 +278,7 @@ static struct stm32_mdma_desc *to_stm32_mdma_desc(struct virt_dma_desc *vdesc)
 
 static struct device *chan2dev(struct stm32_mdma_chan *chan)
 {
-	return &chan->vchan.chan.dev->device;
+	return &chan->vchan.chan.chan_dev->device;
 }
 
 static struct device *mdma2dev(struct stm32_mdma_device *mdma_dev)
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index c248c2dec956a..3d5ca27b6e9d2 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -215,7 +215,7 @@ struct sun6i_dma_dev {
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline struct sun6i_dma_dev *to_sun6i_dma_dev(struct dma_device *d)
diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index c133535d37656..ebb734f807a3b 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -406,7 +406,7 @@ static int disable_channel(struct switchtec_dma_chan *swdma_chan)
 static void
 switchtec_dma_cleanup_completed(struct switchtec_dma_chan *swdma_chan)
 {
-	struct device *chan_dev = &swdma_chan->dma_chan.dev->device;
+	struct device *chan_dev = &swdma_chan->dma_chan.chan_dev->device;
 	struct switchtec_dma_desc *desc;
 	struct switchtec_dma_hw_ce *ce;
 	struct dmaengine_result res;
@@ -851,7 +851,7 @@ static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
 	list_for_each_entry(chan, &dma_dev->channels, device_node) {
 		swdma_chan = container_of(chan, struct switchtec_dma_chan,
 					  dma_chan);
-		chan_dev = &swdma_chan->dma_chan.dev->device;
+		chan_dev = &swdma_chan->dma_chan.chan_dev->device;
 		chan_hw = swdma_chan->mmio_chan_hw;
 
 		rcu_read_lock();
@@ -1009,19 +1009,19 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
 	rcu_read_unlock();
 
-	dev_dbg(&chan->dev->device, "Burst Size:  0x%x\n",
+	dev_dbg(&chan->chan_dev->device, "Burst Size:  0x%x\n",
 		FIELD_GET(PERF_BURST_SIZE_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "Burst Scale: 0x%x\n",
+	dev_dbg(&chan->chan_dev->device, "Burst Scale: 0x%x\n",
 		FIELD_GET(PERF_BURST_SCALE_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "Interval:    0x%x\n",
+	dev_dbg(&chan->chan_dev->device, "Interval:    0x%x\n",
 		FIELD_GET(PERF_INTERVAL_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "Arb Weight:  0x%x\n",
+	dev_dbg(&chan->chan_dev->device, "Arb Weight:  0x%x\n",
 		FIELD_GET(PERF_ARB_WEIGHT_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "MRRS:        0x%x\n",
+	dev_dbg(&chan->chan_dev->device, "MRRS:        0x%x\n",
 		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
 
 	return SWITCHTEC_DMA_SQ_SIZE;
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 64cedef1050ae..e36111e8a76dc 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1537,7 +1537,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	 * the channels available and registered for the DMA device are used.
 	 */
 	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
-		chdev = &chan->dev->device;
+		chdev = &chan->chan_dev->device;
 		tdc = to_tegra_dma_chan(chan);
 
 		if (use_iommu_map) {
@@ -1554,7 +1554,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 				return dev_err_probe(chdev, -EINVAL,
 					   "Failed to get stream ID for channel %d\n", tdc->id);
 
-			chan->dev->chan_dma_dev = true;
+			chan->chan_dev->chan_dma_dev = true;
 		}
 
 		/* program stream-id for this channel */
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 640b8a218c9ad..33811e7ee6552 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -256,7 +256,7 @@ txd_to_tegra_dma_desc(struct dma_async_tx_descriptor *td)
 
 static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
 {
-	return &tdc->dma_chan.dev->device;
+	return &tdc->dma_chan.chan_dev->device;
 }
 
 static dma_cookie_t tegra_dma_tx_submit(struct dma_async_tx_descriptor *tx);
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index fb21e0df5ab7b..4fa6e81ff5a86 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -422,16 +422,16 @@ static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 
 static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
 {
-	struct device *chan_dev = &chan->dev->device;
+	struct device *chan_dev = &chan->chan_dev->device;
 
 	if (asel == 0) {
 		/* No special handling for the channel */
-		chan->dev->chan_dma_dev = false;
+		chan->chan_dev->chan_dma_dev = false;
 
 		dev_clear_dma_coherent(chan_dev);
 		chan_dev->dma_parms = NULL;
 	} else if (asel == 14 || asel == 15) {
-		chan->dev->chan_dma_dev = true;
+		chan->chan_dev->chan_dma_dev = true;
 
 		dev_set_dma_coherent(chan_dev);
 		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 4fc5119854ec1..f414e41d90013 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -93,7 +93,7 @@ struct timb_dma {
 
 static struct device *chan2dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 static struct device *chan2dmadev(struct dma_chan *chan)
 {
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index fe33a20abc614..0fcec3f21390b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -325,7 +325,8 @@ struct dma_router {
  * @lock: protect between config and prepare transfer when driver have not
  *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
- * @dev: class device for sysfs
+ * @chan_dev: class channel device for sysfs, some device use it for per-channel
+ *            iommu mapping.
  * @name: backlink name for sysfs
  * @dbg_client_name: slave name for debugfs in format:
  *	dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
@@ -351,7 +352,14 @@ struct dma_chan {
 
 	/* sysfs */
 	int chan_id;
-	struct dma_chan_dev *dev;
+	union {
+		struct dma_chan_dev *chan_dev;
+		/*
+		 * please use chan_dev, dev will be removed after all user
+		   switch to chan_dev
+		*/
+		struct dma_chan_dev *dev;
+	};
 	const char *name;
 #ifdef CONFIG_DEBUG_FS
 	char *dbg_client_name;
@@ -532,7 +540,7 @@ struct dma_slave_caps {
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
 {
-	return dev_name(&chan->dev->device);
+	return dev_name(&chan->chan_dev->device);
 }
 
 /**
@@ -1805,8 +1813,8 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
 
 static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
 {
-	if (chan->dev->chan_dma_dev)
-		return &chan->dev->device;
+	if (chan->chan_dev->chan_dma_dev)
+		return &chan->chan_dev->device;
 
 	return chan->device->dev;
 }

-- 
2.43.0

