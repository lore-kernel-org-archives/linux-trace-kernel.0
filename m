Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5A581255;
	Wed,  9 Sep 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970968; cv=fail; b=UkXSPgU6K3PEA0ULIswOUmKQT56m7Ax76yKion+71Ruunpe0zKeQBt2TezIG4wGqQHYV8eRQ5mPhsMqy408lahBDiV9ZvZFTcu8YsOxqVnArvRgkpjP4+gzflWYi/ZW3BMxdgfy3FCTriq/rJLkImAOlLu+OBXEc8vrzfBp40VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970968; c=relaxed/simple;
	bh=GwWfo0MsxKCelE2Xo0jbTOdPa28b2DtON2PxVX5DKdo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ppQm9CPxf52e1Gzzv5tMq6LS+73f4XAVb5NETmLWq7YBVs5VknVMKwKSpRaH+zbggTOEAOBZw7zaDq9Y8ue35A1Vj3tz2tWWppXBARN+nxQPuzjqRS4wqYtSBwuLFBit73pzhPYw0dHgOsyO7Xc4hmCHrRR8mGKTeVZ7rZQCIWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S/s73/fW; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S/s73/fW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVENk5hZrmc1IKk86oEQC/Mf6uQnKzVe8G4iQ3WyUGkMRWx4CHhM89/ShoJuJlBjR3etnfAK9AAIfBLmM0gJYP/VeAgxwwMsqc1Xv6eZy68HAlvCSSLUarER3sCJPF6infJvXb8N9wGNYXY/VjGVE03WbETUNkzWF/p2HoVqDtGbois7b9cnTHRJkpDsMerpKJQw0LXZ3t+FAoQi55Lr/OkiMTRqIOg1R3LXJNpJlApkJ/U+yvMjQiNI7Dt4vM09Z3BrXgqDHHLgdtVaYYpaggQAp097Mv7e0AN6bGJFZzlxXP3f/UUNZ1NdBjHuKVz47x744R5oreYIQGWqkPV82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7qBuTb+KutPZrA5F9ZBIyplad8w+M0A0/guNzj9IsE=;
 b=jWd3YbIFoHPDCNfpmc8Dh6fvQocXq8Z2CuiUmbvsa9VPwjPdPhBRarsBtzR6v4dwj4/swaJUdcrgmydtZnJrPH7czOv+eVBR76FqFhLo+KQvngPSCibQU0wym4m736uVItWsXh32ZXQD82ILe23PvzxhMvQQFcTvnQaLDFpQyRge9vzgTOqAXXoDrO3hWlp2qQlF4mzEmzCELgY/LvYyMEZSysyoyqQ5ZHFts2I75O4CinVz2HaBsXE2f9pJMLiNhgBvVglH23bF8V3cU8JIWxDcipYXtlnIuomTTAALSeMKAN2izgYXDALiOEcYW2erFBcq6dfIeGwbOOq7ZQM3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7qBuTb+KutPZrA5F9ZBIyplad8w+M0A0/guNzj9IsE=;
 b=S/s73/fWDPkZ+nrGFruiA1iAtJR/thYA/L2N/bTVP9z5hWpUo3sMbFNoZ53JF5c0tjK5ZydZ57XAlhGpjaDW5Do0DeZ1JW8ouxkjMXbehJFbknEdNF5vSu/R8iRxratBmOwBjvzacVQ5/D+sojAU/6WZowvyA2m/CHBqv7hWY89m+U5XojggMqYlRzfC2W1P1RfHE+2OSBxxYOI2bAZhO/bGsFZTjp80Al/3HPGwD0N3VSatjcNDiDaGwmenBVw3oBONE4IPhU9MteczhwbYlJ6RfXB77178LB32YJcRLqJxnThJ/dleK/61q2dwMGd9nNkVzsCE7qwY2o6J6IDwwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:22:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:22:41 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 09 Sep 2026 12:22:28 -0400
Subject: [PATCH v4 1/4] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-dma-chan_dev-rename-v4-1-d8fb6892a70f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788970951; l=3885;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OFv0LLNCCFn9r7iFKLwYv5wjRFV6X9dhZp6lrtRjCLA=;
 b=/xbOuV+mCN1vKoP/BCG1Vy3EgbVc7ACsQDNCrhkp9R65ulDxvHpIYeuSBZ6uMYm1Gy7AgCJpo
 qnKCX+HYESdDGJNgYjGs9wDpHXTOyWL0R9AbDvIZbIvtemNF7XClPPv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: fd764aea-98b9-4dba-ab33-08df0e8e926f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|7416014|376014|366016|10067099003|22082099003|18002099003|11063799006|56012099006|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	tG9qTh2s1EHkMEn0ultP+cUMK9U9UDRO1N4Kc6LyhXdExsFgZVmKYHlvZU17ghV83E1G4ne0SV5FJWW+nArXb7tujbNWkCrAZl/RbCnAmXV3cMDrDIYZkHE+xBWrM9ZDpS3haT2S3fWS74S1FcKOQbHq0F0+8o5QTgO45srpIm9EmcCHFotdKfWvdGj1x31hY3yD4ICY+jkDp7rzpZ1eNZV5b5vWLjLCV64mIr+tG5ClvcmWKoqg00ZeIlCNYlBdgtbBZhTZ6cn5CHUBTmhxw3+8OIz00tpgXZtIsaLxnTslssrYq6TWRVeI1+zqBKhHUmxfbzFhkYTSCwiNpoHr7lIyl/ztgJa7O8U8gh7lmt0NuiEkH+iDKV73+DHGTbWyPk5pWWw3EJFWw5JG2pHvGHp6CqCjm5tIdTd33CapTxXeLoUi5wOSIwfJgXBSE3emJ9SoUGHsYxdWoNYzLLNCCIcovq3abqPPR5RQbrGdVWEmbYFbionljusIa9tef8/V89T1574fNtOtTE3BTs49pv2LOaotImPfhfH8KuzYAvPVsIrIWYTMid5hT1uTVN5QftOzwVs7LePT9JRH8O3D7q4x0S2SKHVy/5Vy73zJnm1MZfg7cy3n3RGMyj7EWtWSzJ+6p+1pyBV8YLyiU6C4r5SYr+JEb0P1kmELhVcbw60tVoHNxFKycAjiX5pV/jmqBHYUogDaxanxUKDNr+EgFYAZu+90GiO8Iz/fV96PkMuaGMJLmQuZHCASF2IWKfYX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(7416014)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlJ4Ukp0TjhLOGI5SFlFWWNiYUI1dFRaSHVvR21hcEthcUt3ZTVocEluNEM3?=
 =?utf-8?B?V29JZ0RtUlJKbjU5VFRxc0RHTDVzWDRuOGphZGVBNWRhVWgyUEVzMjdWbzZY?=
 =?utf-8?B?d2pMUzh2Mk9QdHUwc25FUUQvRmpIck1BVUdoUjJ2Tmgyc0tKQkViUFJFZkxB?=
 =?utf-8?B?QnlIRG1PbzdHM1VZTFZEejA5MEtkNVVzZS9Ib1ZPbjZVbXZVdS9pTUdNNFlL?=
 =?utf-8?B?bjRxMnR1cDRhcUo4R0I1b0R4cTY2d0xuSGlnbTZCOVRqMUZLb2JrVGc1V0R3?=
 =?utf-8?B?bWxJYlMvRTE0ZzdSWlZZelVET2trMVBoYm1Ld3hNTlQyand5MWxIWFdsU1NF?=
 =?utf-8?B?aVQvZ3pJYy91bGFaT3JVMzZOVEVVdkIybDF2N2t2WXY0OENHamZnNHgwQlFj?=
 =?utf-8?B?a0ZOTmlpZzB1Sms3RmovVWhSSkhubnhPOFd6ejkxTGVzL3FHMmFySUV4VlF4?=
 =?utf-8?B?Z1JNdUhWVVBBS05nVmJyZFBVNW4xVmFQWTJTSXBQVWhycVRqaGduWENJR2gx?=
 =?utf-8?B?aFVLVVBHM2FiMUovZTMrdUdGTWVQVmFqOWw3dFo2Vm9IdklUUUwyOTJTRWVS?=
 =?utf-8?B?cWJJOWMzU0tVQWtURzVmUWNXdVZaWnB3NXE0WjhVUGlZN1pESTlIclN5b3N2?=
 =?utf-8?B?OGp2YlY0cElMMkQ0YlpJQXZWdUlEdW1laEVOZCtZQkpEU2F0VjZBUjY1czFp?=
 =?utf-8?B?OVh4TVJ5WUY4OEp0M3pnUTdodDA2ZUEzNjNmWTNNMFpsQ3pyVGhoL05vMkdr?=
 =?utf-8?B?UGFiUTBZOTZxSTYxQ0lGelpoZnJzY2haTjczM2VWamFpTU95b0JVTGlqaHV5?=
 =?utf-8?B?Y0xuRGluYTM5c0ZrZmxvZXdYTUZSSW9BVmI5TStJekptUzJoekNITGtQK04r?=
 =?utf-8?B?T1JKYk1nTFN2dDIybzc2ckVzRlI5aDJtZTVGeitHVHBxZjZkcjg3NVBUclhy?=
 =?utf-8?B?MlhWMGlEb0w0WWNHdUtpZnJXNmdMVmIwMlZoNlpaTU1Pbkhvd0JuTWhHYUJm?=
 =?utf-8?B?YjdFblVkbFdYZllhZGViSVU2a1FIamRHbDJBSElYbTN4MVNnM0UweWFUbi9Q?=
 =?utf-8?B?YkpCWkFJdzdwcmVBbXBrRWVIZjBtVGd3ZnhjUldKWjZ0TEVPYTIzMXlDK2Q2?=
 =?utf-8?B?bmdMVkN1RFB2MjV2ajFBejdHWG1PbHZvNGpJbFQrTmdwMWJZWmF2WXZPMVBD?=
 =?utf-8?B?c3k0TkRIME43K1FqOVRnUGdIR0ZnNWtRYjJVd2QxMjZPeFFVOVVNbldNOHkw?=
 =?utf-8?B?blRVd0xNL3A3TnRMQW5xc2pEN0lHMmd6TjFaNUh6SjFaZldqc2JZTkgyMXVj?=
 =?utf-8?B?Vzg0VGR4OEFhUk5kYTBadVlCQUtiNDMvb2pnNnhXQndKQldac283U1BySUJy?=
 =?utf-8?B?cTRlazJja3YyMEFWdWZDL0w3eVdVdGhxOGxnSEhsRFNPejdvc3p2RVdhRmUw?=
 =?utf-8?B?VEtJK2N3Sk9BU0tJdk1LTVdvZFJ6VlVmZGRSVGdRUytiZjFBLzZ2bDN6TVpY?=
 =?utf-8?B?ZlVHRzVCWWVibFIxbnF3ajV0ajB1WHVUVU5ueEU0SEUxWkd3bnhvWk10akYx?=
 =?utf-8?B?Qi8zWEFFN3pISjg4dXUvOFdMSXFIYngxY2RmZVNUTFY1QldRTUFQVlBiSU5G?=
 =?utf-8?B?K0pVaWtkdDIxMmM0eW03MWhJcG9yVlJNZWcyYUVvbDFJaDZpZllYbkNJT0lV?=
 =?utf-8?B?NTdjanY5ZkJMUUx4V1JZM1dlWXJjbTBsZXQ4NzlaNmNVb1E2c0dBam5vWUVm?=
 =?utf-8?B?dU9mNTFoWVpVQ3cxWmR2dm9kL00rdDBWQWJEamI3cVlYNU9HSFdrVTJ6bCt3?=
 =?utf-8?B?ZzV4Y3JvNjB1TnhDeWxjbDFudFFWT2c2UWZzT3gyQU1nRHU3cjBSeHdRVkg0?=
 =?utf-8?B?bHZMalFHTEdkL3NxWFdhWGRUNisrbGxlSWFPSGFDZFErTDV2TGw2cGdBcU91?=
 =?utf-8?B?dnlNeTdPdi9UWjAvVVNsbGZ3RkRrcDNuMjZYOGUwV1JaUFV3WTA1Ky9QQlkw?=
 =?utf-8?B?RS9sdDNORmJRRTJKNzlmakhPSHVMekJLcW5teDdZMnlLWDZmYU1MTVczcGE4?=
 =?utf-8?B?b3pwUkZZVFJTa0RXeUpzeWtYc0lCSEhKTzI2eEkyZVVmTnZvVGhabDdYNUtN?=
 =?utf-8?B?cktyTmFuNFNOQjcwQ3U4MVFLcFFhZUxtUXZhMUc1OSt4bE5qQjNiQ0lKcm9I?=
 =?utf-8?B?Qk02Wnk2N1Q3SWZhZ0JMVHNmVDZqcE9ReWN4WmliNDFOa0RhVWU5NEZXSW5F?=
 =?utf-8?B?U3o3aFRUcStjUlZOaldycHhKd2I1NWVteWYwRHJVays0Z3p5M3h5NE5BM2lY?=
 =?utf-8?B?RmkzeFREWkxISStEV0gxY29uWkJGalZ1UC80bEpBY0lhZG5QNy96MVJNY3ht?=
 =?utf-8?Q?k2Tx6gdle32k5xBc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd764aea-98b9-4dba-ab33-08df0e8e926f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:22:41.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhPkKfaC1va+EcvvpcB4qKZ4GO0hYrieFTDbNRnEsObkaKSgo/e73QylIuLIug/rNcCcDFSOMlmcUq5Qx+zQdIE2sjLp/O7aZFXlmxc2M7eRcKp21kXoT/sT9LtudtBq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

From: Frank Li <Frank.Li@nxp.com>

Introduce vchan_chan_name() to obtain the DMA channel device name.

Use a dedicated helper instead of directly accessing dma_chan::dev
so callers remain unaffected by an upcoming rename of the struct member.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com> # For STM32
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

