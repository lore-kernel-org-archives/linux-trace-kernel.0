Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF557F72E;
	Wed,  9 Sep 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970989; cv=fail; b=QxRY9MZlwlRgVadYz42tgmP3kehb51n0klgs6nDG/6zUJAPJw01l3SZgQnTRTNN6OYzqj4lZbeL0LYpvcEC9W/Peqd1ST+wZEeBe4kcpWTsM2+ea2s976AVMUt2Y01Rx741+5+62Q8x5rU/4PfYdyq75bsIsmdpMv0lfzSIcIY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970989; c=relaxed/simple;
	bh=Ua0YwGFSrxEWjUVeaNv4r7bsH+XK7b+1JLJ/YN4lWcM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uA1gpmuhXfCuajTQfh30d8EnQFrr8k57cNuwkQGkN4NBHHdvKmXs1Knq7yEc3cCwyu2JjzETwfKN3UrqCIdQJDNc/ct28HoPmmAFLLDq6oUxqEUEV8Sag6vDgnfSnoN1vcn3t0+C+zK+R49EcsolTJ3XDgCrdROEtjOj826Gxd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EgkGXJrI; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EgkGXJrI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmCyBJFF4/JJjLvKG4S0lQFVDQ3CETjF7DRX3GWG6w0zdWdVpUobRijswCdDFV0LLt1cZ7ISO4BHIQ9zvqubOJThoutdeOp4yDjWs5D5VrMGUoW/36jWMGNbXZaeXct1oV6ZJmJPkCJ1ObGMc/J7oKQwmam7knVMvSlX1cdMFa/GQIqWzi6qG9woQWiMBKNJPp8kXjIWZdW9SVwRxDEuvXtonJzkw4QLlLRJaMHOtAesfcL3R1x0oVkauZEpItngpWOGFTf+E80rdnbEZmA6VFyxpWZMNxsno0z3s1fQoH/nOWKJNY/9Z1jV4phY2ce07CEQAplG45VCFOuDHdM7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7abauvZzDACK0Ed+1mJvu+H/+yYSq0K/zf/n2yHRa2E=;
 b=xtDCjuB4wLKnX/IkKFMRBnsHIJ6dhgXexcJNJAdc9In/arQTdTFuAPGok0bVCHEsZ91dLquC0t2UOxqBcwHPxdw3N4Bvp/qIw0GMH+mTe6o5XB1ir2oTSrhXWSE9phZMYVO1j0eoFoglg8ccRGh18soT8joNaFoAlTOV/pT9LgZwlmcJgB2ssGnpXBEAnrl8S8m3OXAkybUS6/8Wr1YFzo7vWRVa3zgDbp/uqM+MQb2ZuBrE0ROm08Z8Iq2puj0HI/MrrkEZVry40rv78P5lQO095+5dqchnebG4f1XH70gmioRi4KMl59Cdu1UCYr7Q15ZMGzcw6PP5Crq5iKZoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7abauvZzDACK0Ed+1mJvu+H/+yYSq0K/zf/n2yHRa2E=;
 b=EgkGXJrIDu9sZjzAztwkv+/7JgE6a23nn4l/AE4CZYkVwcdlr4Yiu+Hz7AbgUeX//MKqrKKSyj6ior48Tz3WcNUO0mlup0QPCCcA0sCm8XdG3sBaMGNEoV063Rmm0pJNHLSlcegEknajkXQiVtLcQZGPghal/eNowK/Ta3kqQG3yARB0MvV/RqKrQA4yQb5YkJTzh1GmOKzD0h+VKNJdClXGSXz3RbBnUk+N2R9fF3q4NpUa3JrmmUwkgmMHlpJYVYgjzjtTdQ64NZTqGGcr8g5PSjMcnQjdm2xUml1Bqxc56RK7CSomBeX3V7RAmGsZUjmy2zFf9TuCrw5dF6NPjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:22:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:22:58 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 09 Sep 2026 12:22:31 -0400
Subject: [PATCH v4 4/4] dmaengine: add union chan_dev for dma_chan::dev for
 clarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-dma-chan_dev-rename-v4-4-d8fb6892a70f@nxp.com>
References: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
In-Reply-To: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788970951; l=6095;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gHj52vD4WNLOndR1YWKRKx1PK/eHQkOd6+tAOWX9+Io=;
 b=rLyrCMSAaeqf737nI0+3KNhYuzF/PHdlwAvBsq4aslxfuLfa/LjJBtXopLfwIeM8T6ydrDSDy
 +nEvaBDW1XCCj3gdk9RYqFRLEuKRCAio2Q4L8qi7QDJ3vYzzyYeyJdN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: e9789093-cbbd-4b38-eae2-08df0e8e9c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|23010399003|1800799024|921020|10067099003|56012099006|11063799006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	7pwalToPSEwKsAy69W6aq4wBxqMbZUAqZVi7/iqc30RZq7sT1hV7GsGncKTcJ5Xd90zhx2Rqlk8JgnmGU3uzTMhualDiWh1izNfs02o2/qeKMopcncWswenOkIH/wb8ExokO0v6Ru6cIRg46jVZopD+EiAfXHafh6QL/THWwvi/j2zM0c5lcpUfQ4pfNGGTcrcrupeADkfznMpf8jHC8nk3XglM1gN8LGImA2+p48p4kES5981HPQlkiN545fiKDp5JHgVaqNLLB/riplH7mSvtph8fhh2v7ta3+HhAXaF9V9hKl99eMCAWzmV0rqlqMdM3NrBAaINiZGidPxpZ7G7iUja/OIO2ij6VhD4jWB1+4p9NOdiv9IdHlZMXgCO5d3Dtcpo/Wm2of5wLSrsoQ+jhVdDhoBdXSJMeWKnpFAJqkkOQv7YKPOOQE4CmTmDf/qcbFTphqM16qpfTeSQ0X0F+nAyyDs5DTi5XZuEXMlj+R9MVX+8TRu/8my7W5umWtFvghnhEagAvWmN69uB+Es5f5L821ZgiuyQQkMyNCtEiQxV3L/mm78yJocnNfFLN0Q+1ZDjsI0RbIPBbXq3yfnNaHEMMgKhr+/cB1/4GzyKmJpCa4iAv3efmpbTdz0wXNECJa5uipwDF55JMUSMOvP3vK/VxKp3rZlvtCEi24G1DNjsby0UgzDSq/uQyDtmCW3/qWNSDF3n1r/cyK3heTPnlfpsaMJT0QZh57G+t/qynP+tA1limnJDzQyb/UqWKI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(23010399003)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXJxenBuQWt5MXhJdkU2alpTb216QWZobTNiK056R1lJRG5pUjRRRk5DY0J5?=
 =?utf-8?B?cTl5SDZUSHJTc0wvVGxsdEg1YU1QZDRtSDJJQkg0ekpMbEpyVGduck9kNFJT?=
 =?utf-8?B?c25MeU01M2FjYS9uMWR6RDNTSUk1MENIbXI2cUw0S01FazRyblMxNlMzWjQv?=
 =?utf-8?B?b2tGUUMxdlEyS0REaHNWcWZGdmpoZVpKd0lYMjE2aXdIKzd5Qkc2R09nRFl0?=
 =?utf-8?B?MkdXTFp1L3NKaW02Tkh6ZTU1WXMzY01FYWZ5Z1czTEZqY1dHcEJsb2QxUTJ3?=
 =?utf-8?B?Z3RxdkI0UG95SlRQUHViRUVtUjRoUmxrR3cvZ0dNa3ZvalE3SU9qTVphazZr?=
 =?utf-8?B?TG95d01sYTFoN3RhdFpjeDg3S09LL09ydml6QnN3eDhXVmsrVDBYejdZeWRu?=
 =?utf-8?B?VGtYQ0JpQUZUc3pra1J3SWgvUHNaNk1idjY2anNuTXRUY0R3MmNzb1RGbGxv?=
 =?utf-8?B?TWJjZXVDWXBUdGpBMDJqd2wzTVFQUzZnakFqOWt4UHlDQjlYYWU1bERERVFL?=
 =?utf-8?B?UTFDSGVDQThFU0J0ZnVLMWozY0VUc2U4eVFzVnpXUno1bGIyOGNmaGVlWW9o?=
 =?utf-8?B?a1ZzNFJuWFFMdUh0WndyOHpBQUQ4b1FuSjJETURFZjkwZ1JuOGUxRmNUY0RU?=
 =?utf-8?B?OVlydVpzSUlHN3JOZEg3enVDYWdlaWRiZGtQcnQzS2NDQzlueXJ6YzBCcFk4?=
 =?utf-8?B?QlFraTlqTDRRM0tIVWRwUmJibm0wcm1TVXUySUdqSG1rc3ZIVDNlTEZNYTY5?=
 =?utf-8?B?elVtWGZjamdHY1NFY3lnVmJiODZoV3lUS3Q2a29mOWdTcVhOeXJVWlhzYmdy?=
 =?utf-8?B?NVE1eXdGVy9aOFFhYjJsT1lickhmRGlKWExaSTIyVjNzK1ZJVUNIVUM2bDgr?=
 =?utf-8?B?ZUhMNDdrKzZnVHNNbTE3OG40TnRkK2s2d3dkMk43V0llMTZVU1ZwMzJhNDZy?=
 =?utf-8?B?eGFzL2p1SitlL0dKdHBoVXFUdHc4TE5tMUNZVENjSEhIdkFUL0pNTEo1Nmwx?=
 =?utf-8?B?NkJNeVFmMEwraTZubERPQ09hWDNwUWI3NjJBSWRuK0ZDRWxsV2ZQKzd2bFYw?=
 =?utf-8?B?RUxYUHhCSXU2SjZlaEdkemZFZDRlWEViZ3FNaFZTbTRtaVJyOWNvUExkaVNx?=
 =?utf-8?B?VW1IbU9NNEp0OWgyZXhrMUc3bGtTcVh4WElNRVlSUExTMWw3K2NsdThHbU0r?=
 =?utf-8?B?ZlBDOW0xNTM3VjBFMGxYVkZpY1pIcFFUbmxNNURNWTNwMG9wN2dhOXdnb3Vy?=
 =?utf-8?B?ZnNlMGdHZHhETUZtaGRNY0NpbS9pWm53K1pZZFowcktpY2c3K1k2MTRoaG11?=
 =?utf-8?B?VmZ4OVlUUElyNkVRRGZ5OS9Ibm9RaHNOTXdxL21OdjBxcGhGaHk3blVxejBa?=
 =?utf-8?B?cnNHZFZrT3dtcjNoUEE4Zk5jMDdXSDBuRXJTQU1MenJod1BCNjZlT2Z1WjFF?=
 =?utf-8?B?MnBDTkF6b0xJQlRKV1VZdWRUZnhDM0QrNFNGTm45dXIwa0tIMDFyRmNGUW43?=
 =?utf-8?B?bjZaNS9pQ0d4a0xyeEpHaFl0U0Q2dXRlcEp0NkpMMUM3SVZFdmVuYks0VitH?=
 =?utf-8?B?RjhMZFNsQ0N0YXJGZnJVOE5JVWZXUXFBblhwVVcwZWs3WTJOVnpRUndBMHNE?=
 =?utf-8?B?VDdLMTA5ZCs0VkIrcyszcFpGVXZvcWFEZ1pINkhlZDYrRHhOQVZubzVST2ZY?=
 =?utf-8?B?N3ptSDF3RFpPNVZxRDhtRU9YdTdMYnlGSXN3RFJIQ0xCK0ptajdEMmVKZ1RE?=
 =?utf-8?B?Wkx3RUpidXJnRkNyeHJ2VE9CWGlhaEZHRC9DNHBHb0dJTFZjQUZETGQ1KzVu?=
 =?utf-8?B?OS80M3pRNnQ5WEQ5emtxbm02TEM4cllkTWppNmg2MFpLSFJRQ3BNeHBDUWZJ?=
 =?utf-8?B?dFEzSkhnMjJ5bUJmQmVUdFZYQnlCUHNGV2RoWG5TVnZ6UWxWUzVaZHVmdW1L?=
 =?utf-8?B?OFZySGd5akh2cE1yampUOUpuRCtPWlozVjEwdm5KUVgxandGcHN6MDNMSzNE?=
 =?utf-8?B?N2ZuK1ZGOFJwYlUyT21rL2lpT09aNEs0TEhHTi94aHhlZVN6dCs3UWFLWTFz?=
 =?utf-8?B?aTlvR0ZlWmFselpPcTR2VWdjZ081RnV0Rmd2a1lldFEyckxSZFlDQ3crdjNZ?=
 =?utf-8?B?VEVNUTA4Q2EwU2RDZUV5c2FlZ1FrYmVpemhGbHdhaDhNNWMyb1VUTGFXZm9z?=
 =?utf-8?B?bFdYUWVwdnRXV21hY3QzY3pZMXEyRTJwaXd4bXpqRnNWZTdOUzVNY0VZQ1p4?=
 =?utf-8?B?M1p4VEtndnMwZTdSSEN5Vk81N1kydXc4NGV4dUFmT0lmVmIrSUo5czBMMzBz?=
 =?utf-8?B?UjBEV0RPMXZRZDVrNy9hc3FxQVBldDNNano0OGU3aVpuckwwdHRBVzh1L1Zl?=
 =?utf-8?Q?ZreykT2TGIlkyqv4jViBjl4Q5vWkVQs8xbZXY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9789093-cbbd-4b38-eae2-08df0e8e9c8f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:22:58.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZEiLnC4iI5iaYVem9V5CjQuUahbxiCPKaloEtNgbWFGZaLx/irSfO7ZMxY1afLo3owBgZvjYViOBtCvoiOzAat6oKocfDa+mjyKR8hSWrMSAMUsl31RKH8JVt5RV58a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
there are other user use it outside drivers/dma/ directory.
---
 drivers/dma/dmaengine.c        | 14 +++++++-------
 drivers/dma/tegra186-gpc-dma.c |  2 +-
 drivers/dma/ti/k3-udma.c       |  4 ++--
 include/linux/dmaengine.h      | 18 +++++++++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index a7ac2729e4d9d..bb30a9aa54d3f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
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
@@ -1103,8 +1103,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 
 	dmaengine_chan_dev(chan)->class = &dma_devclass;
 	dmaengine_chan_dev(chan)->parent = device->dev;
-	chan->dev->chan = chan;
-	chan->dev->dev_id = device->dev_id;
+	chan->chan_dev->chan = chan;
+	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
 
 	if (!name)
@@ -1122,7 +1122,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
  err_free_dev:
-	kfree(chan->dev);
+	kfree(chan->chan_dev);
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
@@ -1155,7 +1155,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 		  __func__, chan->client_count);
 	mutex_lock(&dma_list_mutex);
 	device->chancnt--;
-	chan->dev->chan = NULL;
+	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
 	device_unregister(dmaengine_chan_dev(chan));
@@ -1290,7 +1290,7 @@ int dma_async_device_register(struct dma_device *device)
 		if (chan->local == NULL)
 			continue;
 		mutex_lock(&dma_list_mutex);
-		chan->dev->chan = NULL;
+		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
 		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index b3327aa35de40..e76c58f213d84 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1554,7 +1554,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 				return dev_err_probe(chdev, -EINVAL,
 					   "Failed to get stream ID for channel %d\n", tdc->id);
 
-			chan->dev->chan_dma_dev = true;
+			chan->chan_dev->chan_dma_dev = true;
 		}
 
 		/* program stream-id for this channel */
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 49e2d0014d5ed..78a67cb9d6e00 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -426,12 +426,12 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
 
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
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 33aa1bfc8fb84..c3a49a33307c6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -325,7 +325,8 @@ struct dma_router {
  * @lock: protect between config and prepare transfer when driver have not
  *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
- * @dev: class device for sysfs
+ * @chan_dev: class channel device for sysfs, some device use it for per-channel
+ *            IOMMU mapping.
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
+		 * Use chan_dev; dev will be removed once all users are
+		 * converted.
+		 */
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
@@ -1805,12 +1813,12 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
 
 static inline struct device *dmaengine_chan_dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
 {
-	if (chan->dev->chan_dma_dev)
+	if (chan->chan_dev->chan_dma_dev)
 		return dmaengine_chan_dev(chan);
 
 	return chan->device->dev;

-- 
2.43.0

