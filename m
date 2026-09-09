Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB18568FB9;
	Wed,  9 Sep 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970962; cv=fail; b=qTk+gJ0obIeV+WRk+qFUHmYyfN2OEjbJoxZ3/p3aK3awdAcSuQeOlIJzvaTMj0NzT532Jg8q9nSJzvmVrxfVioy3hMAvN0Z1UdYyAbjv2+TvRUVv3AH4H7Tn7B0+8kJFkM/F7SUD/3iXobZ0icIXtOPCX06MxVl4jxf2H1H3I/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970962; c=relaxed/simple;
	bh=TIeXBMxCUpWniDDSjmr71NSHJiVV4S01mqH+QE/FXbE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CCj+MY7FSZOsKOwLOjxKLEkaxARgeYhRra37ZkCgRFbAw6nE2XnMiorYW0tcdiFQiZJX7CidDnne3y/SktpqAW8++2t+OTPf7tMGmTjKT8xf8M41XYnemULZ+gyQutJ8KZboKTFZk3Wnswf7sGspvnRLPgxgsworKfaqDS7MlfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qDdKUy7n; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qDdKUy7n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZePzVaL7Zt5HsxMrkB0vP8zId6bXhy5YGUxnhnJRnNyj6Xxy2b8oz7waNcGTt4IOgSTddLOIiBLzHHwYotClOg4BwPyU8H9PdM7tHwK797+czFzWkirL5l0mf+ZGPSlBREKGjVJ9ksW/g3wZzfaFF3uIqqbHWJPVx7mlogjFIrC3mvf4u+tF8RJaS8Dn+rEyta6hdN1OFvPDCxGsiGTf5DAkKBYhVw/7+b6Ug1U2qGOszRsDkYxLmDD4q0o4qrJc5kR/r6L8qp1LD0RZVp65fQhRVFXRwmd5gkaXnhvqi3HyL7F4tNyVq4w0QDVIWOZ15W3Ebh6dls1Eyqsj/mR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg3XXo9vNLmVbG2RcagY4hT2vNPSv4tYbgxs6wGCn8I=;
 b=DVqsT4dfMuaVUEkxX+dHWW0D0SNKEwsjl1j8wadA3+1GOzp7Avdd+CLicqOl8Zo3i8sVCxmuFrYNAgaslIyb5+swJPG5SR48ZbiQoZZAUjlRkEtNvvUfuAnd5pvWHe0eG308yQ2pz8OgGMcrLNC5b/wtVghSCE7HHQ6gbV7UNzcVVtmB3aqLKO6SgPaAbhadW4XpPbgIWOJPk/Sz7s6SvQaJvLCu81sH/NcRPYesm7GvJcEAV/GaehPRGfWwd5ySE8/cNrwtltQJJkiW0Wgx4F8rPwyvVcOMtLK7IPBplVEJy8y0cERFyPgYiD5xsTXZ6TKZ1T4EjLiZ6lbgteCZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg3XXo9vNLmVbG2RcagY4hT2vNPSv4tYbgxs6wGCn8I=;
 b=qDdKUy7nCrszHHrWYcZSyLHKx/stGGAvFLmP9NSKLIj/+8nF397Y5uerbcm9MN0d48agETpAsqbUq+dfaaCAc5lboPmkF55Vkiwa8Uut66s5b1/49AGMVG9p58h05wHzy01vHnBkl178yV97bsLkWPK64fYtqOyS2yLxpbcpLXo/QuA+W0apecxM7/N2vcV/1u1rwkngT8lul9WAJqOK+iLLahdYUpt8MLHMr6YexJQJcyQ0f3fnYPMJar4hL/z0TrvuW36GTLRKWqIRtqm7nWCZosz4ZRySMzNVb0ISrPJkNCxJHK5pRrFDLk/urUMp++H75ZF2m+SbhvGo/0sgDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:22:36 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:22:36 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v4 0/4] dmaengine: rename dma_chan::dev to
 dma_chan::chan_dev for clarity
Date: Wed, 09 Sep 2026 12:22:27 -0400
Message-Id: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMOHoWoC/33NywrCMBAF0F+RrI3k0U6rK/9DRPIYNUJbSTRUS
 v/dpC6qUFxe5s65AwnoHQayWw3EY3TBdW0KxXpFzFW1F6TOpkwEE8BqLqhtFM2Xk8VIPbaqQQo
 gQCpTojJbkj7vHs+un9TD8ZPDU9/QPDKVG1cXHp1/TbOR597/hcgpowoqLvm5sqUR+7a/b0zXk
 OxHMQtbJpcFkQRmtWSlBlNx+BXkt1AsCzIJUJfAuGa6qutZGMfxDftzKHZKAQAA
X-Change-ID: 20260812-dma-chan_dev-rename-66263ac5eac9
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788970951; l=4485;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TIeXBMxCUpWniDDSjmr71NSHJiVV4S01mqH+QE/FXbE=;
 b=EVxziEAr/+5BdiDqxhgUkHwC0rAmtjMUTx5OuzUIBJYSKe80ehtqBozMtIcyU7D/4ezAuhNVd
 7XTC+VCYA15CDZJnn47GfstuK+S4x4oo/HAne/2Z3jIoi5bQ+vRLjdj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 21575512-a53a-4ee3-6189-08df0e8e8f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|23010399003|1800799024|921020|10067099003|56012099006|11063799006|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	HP94C6VBBluKBifIyksXv48ak+7qoecbAX+ZyEAe8ENi4Kgr9t5mOtcSC0VvON1CJAvr6mifHvP++zT9ncc9taL/mJe/z1fSS4eNCN0Bd9zDEI9xwB41/A1FIDuW+ZzppEMuJyye8/7Y9CpodBGnkP8I7ieGBZyoUmmtSzwefw2KxAi8of5sAP433B25W5VrV+gMGQ8vIpJ1ynVE0MFExUV1NKOUSa4CpumTF50kHeKdZFV+EY7aq4smYmSkUuCgVV9vM/HMDaLNKKT9ie/Gblny2zwbxAJniyT20Vjnd6O/vm7/UdlbpN2cRl4k60QDRMBiIn102nsbuulruTl9OJHyZYjSRJxOf8ckfzExLWBWujLy7fr2zzAVsRcMbAc5RE5fHSU/dzvyS4bTP36l/tySw4VcIcJl59lzz6mrDjb5Tprh0jAvXRGWPdtlwbn+7xmIQk4D+uRomkhUl4BBeUHIeWV55bfEs7hcKGgs1qEetAtYY34FN6kISaS4BDxYP3rsGjJ+ag+3n/9tqBwPjGwQAAmKqOiNebJPfQcB6F0vY/iCOMPFmse3BJdhrYTLNYGlPSfnBUMogMf+dxveBK0YTQBfz/tQwoZLCV3Ibyh3p8c2/fDm2zoDNEHTGhPoFkICNzeg5D1syHDspzEKhAJSx+NvDT+nPlyXyJRsxeCrFPhHB4TeOtgkXeV4iyC7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(23010399003)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NXc3Y5YXpaS1kxektkbExxRDgvaWZnUUVOdjFzOUZNTGd5bDhTZyt5V3JJ?=
 =?utf-8?B?TjVUVDI4Ullzczd2OUJtNCtXOHpURHR4MmNndTFjT01vTTZ3YXBoTmZxZzJ6?=
 =?utf-8?B?Q0xIcnVKZUliZWhWUk51a28rTW4zdTlPTW5TUi9keE5wRWxnM0d3VE9DRmtF?=
 =?utf-8?B?S28zbm96MCtjU1FyL0Q2bXJDWGZLTkpHNkJiV1R5aHN1THR0K1ZCMURBMlZv?=
 =?utf-8?B?L2REWUVuc3d2WmpvZ3hCVGM0VWpJdWFMUHYyTHQrYUQ0b3dOL2lxbmgxMXQr?=
 =?utf-8?B?Qy9kTkNmY25BeXVZbkY4WlNZb2dWZTFVM2RXYlAwYlp0VEVVY0VORi9tc243?=
 =?utf-8?B?bmZGNWthbGg5UURrZzlFSWJTOGRzcDdHSUJUSnZUZWtCeUF2SGdMRW9oT0s3?=
 =?utf-8?B?NzV4Z0tHaVl5YitQRDZuNFhCOFp2bHFJYld6ZFVqYnFQbHJNZjBWbnZhWk1O?=
 =?utf-8?B?aTltQW1iRjJVczBmMUxJU0hoWjNGSitqSFRZUXpPS2pyVG5JVkJSTEIzb3d1?=
 =?utf-8?B?aXk3NjRGd0ZLV1lGT0loa3k0VEs2TVY5dEpRMmdTZTJmQ2lWVkxBSDBySnFh?=
 =?utf-8?B?dnFMRTBmVTBLNEJ6R1NEV2ZYUXNxVkNKTmhFWXV4QWNXanVmTGg4NHRqVDI5?=
 =?utf-8?B?VmF5M3RoMzA5d2VtcUhSUEFnY3pyNzVBU0pRaTQ0WCtTWm44UjBhWG5xY21U?=
 =?utf-8?B?em5UNFBSQUZVM2ZRSGVPK015Y0t0bEc2ZXVxT2FROG5jM0NhRmttNUVpb1dM?=
 =?utf-8?B?Z24va3BHaTlhcEVKcWkrR0lVQ3Zoc1hXWUJmaCtDdk9CUUNnWXJhWkdtRXYz?=
 =?utf-8?B?YUthdmQvL203NU9QUS9jUS9vOTd5VEJobDdvc09MeDVUalZLOFVXSkFSVVBw?=
 =?utf-8?B?ZXF0Q3pFUm02UDVSMW9oY0k1RERKcldicTVoTlZGdGV5RktVQmp4U0ZrdC9R?=
 =?utf-8?B?MTI5U2RHMWdaSThrbDBnNjZBcjBrZlI1UHBPdzNqTklrdmM4ODYxdDZNV0pr?=
 =?utf-8?B?RFdnODZGSkRTbjJZU0NBd1ppRHBmLzA4YTVERlFRYmgxeHE5UDhERnZ6Ynk2?=
 =?utf-8?B?SEM2T1JyeHJyS09tSkhrdjJGYzkrSmlDUVpVU1dmMXl2eWpRaFZKQ0xyM0w1?=
 =?utf-8?B?OE92YXFKTHZVdTJrRlJnNE55eGhuVTROYVZZYzdqVml4MGhKNUlGZGhEbU5n?=
 =?utf-8?B?UVZJZmdOU0JzZ1dmazBaNGN0SkJtUldsdjQ4aUp3M1doNTZpWGx2eU5KcCtx?=
 =?utf-8?B?OWx3b2hpQTRJOVRoYmQvNmJlb2xZS1I1V0NPQ1J2RGh1TkJSMnhOakk2aUdE?=
 =?utf-8?B?bTVyTXdGZXRyUG12UmN5NmlzR0VMalFQNDBTUmdjV2NlSnZlM2R4UE1iMkE0?=
 =?utf-8?B?R3piM3lSS1c1d3kvdGZSQnM3WmpsZHFSZkkwei9ZcDkvNGF5b0d6M1MzK1Ba?=
 =?utf-8?B?bmFUSkVwbSt3b0o5bVI3WXppZmVUdzdiY05vY2tGbjhwRXc3NlUzNlFOcW1s?=
 =?utf-8?B?NFJhMzc3eVZYNDd1OTI4L291VE9nUzRZTzJXTlBleXFrZjZJUHNROGZJb1ox?=
 =?utf-8?B?bDEyNkVmY2RyM0toWDdjTldmeVlFZGRTeitkQVJHY2hnSHpqbEtJK2RFUk5w?=
 =?utf-8?B?UUJidkx1S2o1bnFPamRBZWhxVmhSWTlVS2F0UnI2aUoxMkwyQ1JVVDE4VUxX?=
 =?utf-8?B?SXJvcWYyNkx4Wkwyb3B3UklNSjlpYncrZGF6UTVhR1RuWVVhV254MEJVd3l0?=
 =?utf-8?B?bnhoSnhYbVZFamc3elN4ZzNoVnZ0aFJqcGltbC9QOUJBVkN6YWJCTzVwRjJW?=
 =?utf-8?B?YjA4dDNTY25OUW1lRnVUVHhMSlUwUldPcnAxNmR3WklQd0pJRmJzdzh4WXdZ?=
 =?utf-8?B?VXUrL3BoVjFCNzJ5UTdDdHNxc3BlbEFlRW1YU25iT0lYcm51ZFlGMFlkUjk3?=
 =?utf-8?B?T3hua093enJqSzM3VGttdWFVbVNWbGdUcmhhMHJvODBBQi9vOVdycUZLb3N2?=
 =?utf-8?B?SlN2Y2pSQnRHcTNkd1J0VWNITFdVVU05aGtkenJaUjJwb0NXWHI4WFFTbExn?=
 =?utf-8?B?Z3BqNlVuUmFMQ0hPWFBvTjkvdERKZVBKMVJOOFdSYitaYTVENEdnenRxUHhR?=
 =?utf-8?B?NW1sQ0Zuc1ZOK2txV1MxMWxBTisyVWNTcWd5cWo0alRyQ2NLSE0zL3B1aFZz?=
 =?utf-8?B?RlZZUzJZV1k0d25uU1ozTG1JUzlGR29jaU5XVmw0dGZsaGpqM0ROU0ZqMW4y?=
 =?utf-8?B?TmRRVU0wd0RGNU1jVnlTQzRBWVoxUGRiemMvOTZ6L1lkYXQ0YjhUMUhUa3JI?=
 =?utf-8?B?WHdISmt5eDFjNFlsTUlvMnJSVThOemFZUU5BbUxZbEQ2SGNBZkV4bk9Jak9V?=
 =?utf-8?Q?c8HoM7ISxX74xqKw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21575512-a53a-4ee3-6189-08df0e8e8f40
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:22:36.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xguPNjn/yJfDvexI/uDE6+JDCTl1VlkG494OygR8iBM3a87U0OKxH3Zlxaeg5baAZtHaDELfTGS9rDILGqr0BRu8RtXVNvTuRqwgV1lMA3f2Lg3P4BSZ2ZBS1xT+Nw/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786

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

1st patch add help vchan_chan_name()
2nd patch use existing helper dma_chan_name() to reduce rename difference.
3rd patch add (dmaengine|vchan)_chan_dev() helper
4th patch add union chan_dev for dma_chan::dev for clarity

Need following patch to clean other dma engineer driver, which is not
in drivers/dma

After complete all rename work, dma_chan::dev can be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- move some args to previous line to reduce LOC
- s/iommu/IOMMU
- fix multi-line comments at patch4
- collect reviewed-by tags
- Link to v3: https://patch.msgid.link/20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com

Changes in v3:
- add new helper function dmaengine_chan_dev() and vchan_chan_dev() to
make clear.
- some reduntant error message will be addressed by new patches.
- Link to v2: https://patch.msgid.link/20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com

Changes in v2:
- rebase to dmaengine/next
- add vchan_chan_name() help function for vchan case.
- Link to v1: https://patch.msgid.link/20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com

---
Frank Li (4):
      dmaengine: vchan: add vchan_chan_name() to get channel device name
      dmaengine: use dma_chan_name() helper to get per-channel device name
      dmaengine: add (dmaengine|vchan)_chan_dev() helper
      dmaengine: add union chan_dev for dma_chan::dev for clarity

 drivers/dma/arm-dma350.c                       |   2 +-
 drivers/dma/at_hdmac.c                         |  81 ++++++-------
 drivers/dma/at_xdmac.c                         | 159 ++++++++++++-------------
 drivers/dma/dma-jz4780.c                       |  10 +-
 drivers/dma/dmaengine.c                        |  34 +++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  39 +++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  10 --
 drivers/dma/dw/core.c                          |  47 ++++----
 drivers/dma/ep93xx_dma.c                       |  37 +++---
 drivers/dma/idma64.c                           |  10 +-
 drivers/dma/loongson/loongson1-apb-dma.c       |  23 ++--
 drivers/dma/loongson/loongson2-apb-cmc-dma.c   |  17 +--
 drivers/dma/loongson/loongson2-apb-dma.c       |   9 +-
 drivers/dma/mmp_pdma.c                         |   3 +-
 drivers/dma/moxart-dma.c                       |  23 ++--
 drivers/dma/nbpfaxi.c                          |   2 +-
 drivers/dma/owl-dma.c                          |  21 ++--
 drivers/dma/pch_dma.c                          |  41 +++----
 drivers/dma/pxa_dma.c                          |  52 ++++----
 drivers/dma/st_fdma.c                          |   2 +-
 drivers/dma/ste_dma40.c                        |  15 +--
 drivers/dma/stm32/stm32-dma.c                  |  69 +++++------
 drivers/dma/stm32/stm32-dma3.c                 |  99 ++++++++-------
 drivers/dma/stm32/stm32-mdma.c                 |  96 +++++++--------
 drivers/dma/sun4i-dma.c                        |  17 +--
 drivers/dma/sun6i-dma.c                        |  31 ++---
 drivers/dma/switchtec_dma.c                    |  14 +--
 drivers/dma/tegra186-gpc-dma.c                 |   4 +-
 drivers/dma/tegra20-apb-dma.c                  |   2 +-
 drivers/dma/ti/k3-udma.c                       |   6 +-
 drivers/dma/timb_dma.c                         |  63 +++++-----
 drivers/dma/txx9dmac.c                         |  73 ++++++------
 drivers/dma/virt-dma.h                         |  16 +++
 include/linux/dmaengine.h                      |  23 +++-
 include/trace/events/tegra_apb_dma.h           |   6 +-
 35 files changed, 538 insertions(+), 618 deletions(-)
---
base-commit: a5f8e3471fc20567df888267885dec3eb340eb37
change-id: 20260812-dma-chan_dev-rename-66263ac5eac9

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

