Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2248B38A;
	Wed, 12 Aug 2026 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569882; cv=fail; b=nc/B5Sr/Wjq71iXwVSerhfWwFU98pUKWv9q1ubMJFIChdBcgL8yuB5s1JKSoOwxmOsUN2tutDD6bKfqlMUJEYt5DU7BWzfRwxMT6AZm/euyS16Lx2ob8AIstKppQN/7o8aIBYnxpZqV9hyVAhmAIvGS76hFpXW0kj16Vue4FA7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569882; c=relaxed/simple;
	bh=b95VA9xYnWQvmX6w44mNHtNP9yi3+epLyjvXSGRR/wI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CGEnro6wvRSRcOC2QUBeKpAE9SeinXi0lwSttA6nUQK+wOjeWnKd5kZM2FTSeJL+4deJt0qOqC2paLiZlEB5G5qKDzwZ41Ryk4Augs/Tcd6FYIIqo6oqp660r9q/7qbsXFXCvpmvFntul6RxydRJodczr6q+PvuzOptGSCL+Dgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PMi6CTN5; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PMi6CTN5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRqD6CHndUpG5KQSQzKXMSJY6gZjRcchG0sLG4sbHhbJsbRC4I6fmQQSCFmdtiUb86oPsI2jxVqMti55USvexSIXwG5cyeRgHRVYFhyGrkpD1yeqjmCZZhig6enw/Baoo+U/trcrvRxFU2RpnmD9vAmoDnkcq1EJlO6Q7t4UApILzh+PguGjNmwV0qIE4whp4o1ifmLFAArqB8IDC0DzYwzV51/Y9AOk8M5emXjCSlNgChOCcz4Bu2gH1hvD/OLy61ZISkmfgFc8addleK34eolidDKoaUR5uQz5JmXXvUYLZoun0bc8BBKMxnSn91Abw1CfsWStMDBWS+7uhBFexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0MCUZapd25YYFnlT29VEG0p/2ZvUnD5ydQdaBV/O6A=;
 b=n/UyR+fD9UG/ECrtqkMK5L2+Yf2KPJMqEjGU2iK3OxOHlMiWvhfBlFJcSiFx0UAp0DPi68qz5BRxluCQR7qjBgHOFotJaeuhg9ycD1yZxoQGTgphbpcDGz+RURd/R/4XPWxij9h9FjIf635x3WBFyVf8beLy6Ey1XaoqeNMrML8cuRus/jqP5M1HQWciISVy0FFrdF4wvYpoTqmycGIuKvLTE4GPdt6FsMSW9KxrTd7c8LUpwq4OvPVlMpNCrtNieop4vOqhPhwTAFfe2ACz8WBprnuNJxjeN8lKmfB7Ubi5QX3UGtMP/V5vNI+xCswNLpdaINZfq7t19BPioA9+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0MCUZapd25YYFnlT29VEG0p/2ZvUnD5ydQdaBV/O6A=;
 b=PMi6CTN5PrTNahSV/gfbUN4up0pVJX0lpoNwtkEt3d5Ggn7Xw4WF35mmJEImesSth0Nt98leIe+gXCsLyVI1018s+9zsDAMbbuwWRfDYW9YQFT580iE/HtGLdp5a9IHuxv0U9SWj5KdSFho/z6vIpGTKZrjTb5en5t1j+73+V7LG/k0HXiOgCixUmh9+Ent+ppwp0lHMtabLeLS1qwQbVXZuHWKd65S/soIMouM4Zpot0WUJx1W+a/DPwxZ8pYNaJHj8CynsU8bmw5eTSBpHX0Hpzjk6sWE7jSsbHRYsH8j8ps5kVArLJOiN43DCPAAViyjmkPT1Ujyu4vJRiz2LAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11821.eurprd04.prod.outlook.com (2603:10a6:150:2e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 21:24:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 21:24:32 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 12 Aug 2026 17:24:09 -0400
Subject: [PATCH 2/2] dmaengine: add union chan_dev for dma_chan::dev for
 clarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-dma-chan_dev-rename-v1-2-a67131f7d5c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786569857; l=30289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dDNLoDLRSP1leDJ7kWgXFYzuLcBNbHE4rSZ3rnXCYlc=;
 b=PigVNwYfANqHiD9LFAYXdltYmnUt5XaU02cPOnDPDGWGnvM0d0TV9Yg2PN34HKqglrn5TIGvF
 6pg2oL7RdArBV15pKlrHFjrl3R+4hia2W6UcoEB1FAZcuyoscYOTmLS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11821:EE_
X-MS-Office365-Filtering-Correlation-Id: 227e4943-11ed-4aec-c4f5-08def8b81953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|19092799006|921020|56012099006|18002099003|10067099003|11063799006|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	6Rl/Nqr+3M77dwvRRLx91n9SmxXEKuDGVD3nqv2fczq8OejZqFEhDXwjVIb2WI+GHOu4m50PNLVSv+Nraj3VbWZZOGGEkMPXRuwYC+dEv6wWxRRoOtJnj3qYrV/dUfAX158hmr1AeMqR2NVskZK8OXE622ccTFKeWMh73IwTq9fFI0FdX2rhf8naCUfK0Istw7zWdDfjvQ5aXVuo9eH0bwIwTqh0V+CgCMZkaIa1ojekLjn9jJhflGwZ80UkKf7BfttZY61ABBVqVo9z/Fki/gkRh1kaeqobikLkbH/C+XL12WbVbl2gmWr5A0nyMpntvYjJq8M2QlMriKbqB+IKr/zZALTWD6gDPIXWFPGnYdoLcKnESkKd5Gn0hXJil+qpwaF5UqK1/Ed8EEZaYZwiypUdooN4hsu2PFXTFetIbI/PpOMTReEe4KGZTiYO0MTRP7BcwwNlkEsOAB6ndIo0H2guYjEQCSiLDPi/zIyOv3aKWEki+m57LMsyu6kgwTXTPdDds45BDjc4Txt/uJY3GyZ+7Fc0tN/WWSMGMSZbmsC9buPAgMbhveu9eB0DJ/hsfg2QlI23ikBq/j0E+pep4Xm6m5lMh96AqVT0vb0xHh+aOfm/Ub3v48lxtvXEVJsptgsvM1JU07eqp+d1chQgmOY1pTkF/KoiR7GQZ8XTYljM4gTJSGd4b8642EDwwbYzQLMJZYP5g8EJJuMqKJmlEP50+OyX90kHaKgiacEN9DebLqD6iMxjXTgwTNC/RuC0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(19092799006)(921020)(56012099006)(18002099003)(10067099003)(11063799006)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzlkWmkxNzJyUEhaSE5XelJwMzVySjA0cHBZKzVrZ28yQmtITlJCbHFVQTY0?=
 =?utf-8?B?TmxwUk5KSlA3clJyL2R1dVpWQUVsTWVSNlZDNFRObWlCaHBzUDBTTTRVenl6?=
 =?utf-8?B?MFFJNmNZcFIvc0VLcFVWVGtscjBpOEV3YWl1azFpaWFncFc1c1dwekZjdzBV?=
 =?utf-8?B?LzFESDJteE9hQm9TNzdoeDJwZzNnbC9ZWnJKREVtM3k4NmZuZlBxNUVYaWtz?=
 =?utf-8?B?RGVteUdSZmduSE1CYUhtMk01dVphQWc3d0JFSlVNc2t1akVNeE5ZREFoTDRj?=
 =?utf-8?B?RU5FLzUzWmpickhqeEZZTS9DOFM0dmViQXRhdW4wdkVWOG9ieVRUdW13aTFJ?=
 =?utf-8?B?ZXFKTkVQUEc4MjJBNDdROEJOR3RITEdjTkFyZ3N6cU5WMTFZcTBHbG9Rc2tZ?=
 =?utf-8?B?MUJJS2hXd2lXZE9Vb0ljd05hVmtSTzhrVnFUOEd1MUgvdE96STRleGhIL0cw?=
 =?utf-8?B?dTVrZWkrWFZjL29uUjRiSTZmNU00OFI0QzBSSHFxbEJWWkM4d2xiQVlWck5V?=
 =?utf-8?B?YjhXTU9EWVA0R3cvTnRVSGdzSzFEMzMwSU5KcjFUMXZvVEluSlNGZlZITGtO?=
 =?utf-8?B?NXBNQzJtTDFOWE5pcERKek1UNG12RkV5VFdtanp2Ulc1S1pKYkFYZ2F3bjcz?=
 =?utf-8?B?TDNCTCtMdW1yb25LRG56MU9FcVBzUzh2QU94RXJtZXN4WU1RUXMxU0g3U21G?=
 =?utf-8?B?NEtFL0YraWtpS05ncWN5WHZWN2J3TmNYVVo3QlVRTS9jMmd3RE1UczR6ZnJC?=
 =?utf-8?B?NHl1cXR4TWczdUxXS2VnTStxZForUFFvczRzUGVNZ3EzazF0S2cwLzhiekJu?=
 =?utf-8?B?NTk5cTQ4MVkzbDVma0JDVmNzNitrR0lpV1RKYWJEZzhHb3dFeUQ1TXlQYnZl?=
 =?utf-8?B?VFI1MjBSTFF5RW0xaFdIOWl4U0JxZGhUS2JnV3FIaVlDMDNxcFhTbG5Yc1dD?=
 =?utf-8?B?eTFOZUVrNUxHSnhnNWhTaFFXNitwbGpPSy9OOWhLaUpIbU5EVWZ0VG9uYVNU?=
 =?utf-8?B?QXhGcXg2R2szR2pJRWo1NjFkUFRwL0VpT2pBOUo3WER1QUE0eGt1cXVXYTkx?=
 =?utf-8?B?aEhnNVZVQWJteFh1bkVpODVkNXUxNXpManFmM3FKWTg3clg5Tm9DU0p3eFpR?=
 =?utf-8?B?UGVXcFY3RUlPekE0RForVXZaSk5TRkJHb2ZENTFWTjZJb2JpQ3ZrNnBxZU45?=
 =?utf-8?B?QkFQTE1qcm14ODVBZ0owUXAvV3hwRStQN3cwOVB2VnZzNjk5blQyMVp5cDlC?=
 =?utf-8?B?cHp0bmtoY2d6YWd4K2Y4THU0UUgwY2ErM2ZBVHQ2ZHNvSUNSM0dwWW44UE5z?=
 =?utf-8?B?NjB3ajMyYkwrd2IxRUJVM0l3RStIU05VUGgvYnQ3RS8yYk1QcHlLcjVPRlJN?=
 =?utf-8?B?enhNM0JnR0tsMktHQmpzZUZnbTJnOWNxR1lFLzljRjVpbEVTOUlKOEtqTGNX?=
 =?utf-8?B?Z3dGWEM3TVVOU0p5eHhEYlFhc1RrZzNsTDZMQVdETTJBWDhvV0hweERyTVU3?=
 =?utf-8?B?ZW1iclJmd2xGTlVFSkRiQXVQcjVMYmhlRVc0N2FrQ1NSbnIxMjdoY0orckt2?=
 =?utf-8?B?Vkl6VSswdHpGZWNHdk9XRUNPbkp6aXBpUm5GSHZoYis3eW5MazZ4b2JSanBN?=
 =?utf-8?B?cnB3SnJ6aTdocENjV0JiSXQ4SVU3UHgrYzJCN3hxODA5ejZLVzZlRmI4MWRr?=
 =?utf-8?B?cVB2dnhweHlSWUUrUFc2VjVuQVdya2psNytacVlkWXpFMHg0aXR1VDl4TE9i?=
 =?utf-8?B?R3ZRVE1rSXNVZGx4dzZWS3BJMlplSTgzZDJNL3B4OHpXQy9IRExTVUxkOUhS?=
 =?utf-8?B?cHZVUzMzMVVOSG5aSVV2Tlc5dEw0UW5EMDZPcTNOOTVYQ1piOE9LREFhVk9B?=
 =?utf-8?B?SnFVUm12ZnQxK1lpclFBTnNtQnlMVEZBSWRWNERrekV3VldEdUtlM1d0SWN2?=
 =?utf-8?B?SnVYMG9heHQ2dXhkalpMcU5wd2FFRnBUdnJORitlWVMwNkNWL0ZxV0xEbmZu?=
 =?utf-8?B?UkswemZkSnZSeXFQdFk1aFBHK3pUZUplMzJFMDFDSTdKMVJobWRpcDlCcUtk?=
 =?utf-8?B?MFpxREtmdEVBVzVQaHQ1L2YvbW1zOS9EN29CRnNYbWZPMS95Q2Y2YW5Najdp?=
 =?utf-8?B?RXJQdHhtKy84NDg4eE51SHl6SWZRZ08vZkJGSHQ2QW9vdUtSTk5MZFZHK01s?=
 =?utf-8?B?cXQzalpXRmZvanRiWmdmcXg1L0huNldRcUFJRjE3N2x3bE51Z0d2a2lmVHc3?=
 =?utf-8?B?dVVncDJYelFBamsvdjdZSzdrSmNBdDdrWldQMWFYTXcySU9xQU5yeFIrV1pU?=
 =?utf-8?B?eEQ3VjQrcHlyYXFqSzV5Z2d1Q2RKNEpaOVVZU2MrbCtaV0x2Tm5Kb1ZuRVdN?=
 =?utf-8?Q?MVqgcOEo+DoQi915e15iinwuSnGkpsCP8rFRR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227e4943-11ed-4aec-c4f5-08def8b81953
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:24:31.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxMsqOUgyPSIKU2zk8sNzJokfWdiHL9jRwfYKkYOJK2Tb8IULrWJKc+i4NsBcl+pG1VAuqpF1U5FoUxfKubkiNmHW92p9rNjKRw0a3HVPyVNcoPfoJD6nmnpa+Ze+jos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11821

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
index e5b30a57c477a..63c72f80d9a02 100644
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
index 67cc199e24d1f..ccfd09c06807b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -121,12 +121,12 @@ struct axi_dma_chan_config {
 
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
index f53f24b7f8ffe..dbb85b72003e1 100644
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
index 4e3ecb6763036..5fceed6fd8265 100644
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
index ab0fb05597363..81db3b33cabf6 100644
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
index f47a326dd7ffa..0fa640557fb07 100644
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

